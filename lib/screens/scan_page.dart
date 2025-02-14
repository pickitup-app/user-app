import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../components/header_component.dart' as header;
import '../services/api_service.dart';
import '../utils/constants.dart'; // Contains the constant apiFlask and other constants

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCaptured = false;
  bool _isCapturing = false;
  String? _capturedImagePath;
  Map<String, dynamic>? _prediction;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _captureAndPredict() async {
    if (_isCapturing) return; // Prevent multiple captures at the same time.
    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile image = await _cameraController!.takePicture();
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Use the ApiService method to send the image to the Flask backend.
      final result = await _apiService.predictImage(base64Image);
      if (result['success'] == true) {
        final responseData = result['data'];
        List predictions = responseData['predictions'] ?? [];
        // Taking the first prediction (if available)
        if (predictions.isNotEmpty) {
          setState(() {
            _prediction = predictions[0];
            _capturedImagePath = image.path;
            _isCaptured = true;
          });
        } else {
          setState(() {
            _prediction = {
              "class_name": "unknown",
              "category": "unknown",
              "confidence": 0
            };
            _capturedImagePath = image.path;
            _isCaptured = true;
          });
        }
      } else {
        setState(() {
          _prediction = {
            "class_name": "error",
            "category": "error",
            "confidence": 0
          };
          _capturedImagePath = image.path;
          _isCaptured = true;
        });
      }
    } catch (e) {
      print('Error capturing and predicting image: $e');
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          width: double.infinity,
          child: header.HeaderComponent("Scan"),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: _isCaptured ? _buildResultScreen() : _buildCameraScreen(),
    );
  }

  Widget _buildCameraScreen() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: CameraPreview(_cameraController!),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: _captureAndPredict,
            child: Image.asset(
              'assets/images/capture_button.png',
              width: 80,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: _capturedImagePath != null
                ? Image.file(File(_capturedImagePath!), height: 300)
                : Image.asset('assets/placeholder.png', height: 300),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.green,
          child: Column(
            children: [
              Icon(Icons.dangerous, color: Colors.white, size: 50),
              SizedBox(height: 10),
              Text(
                _prediction != null && _prediction!['class_name'] != "error"
                    ? 'Category'
                    : 'Error',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                _prediction != null && _prediction!['class_name'] != "error"
                    ? '${_prediction!['class_name']} (${_prediction!['category']})\nConfidence: ${_prediction!['confidence']}'
                    : 'Prediction error occurred',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isCaptured = false;
                _capturedImagePath = null;
                _prediction = null;
              });
            },
            child: Text('Scan Again'),
          ),
        ),
      ],
    );
  }
}
