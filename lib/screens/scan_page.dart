import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import '../components/header_component.dart' as header;

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCaptured = false;
  String? _capturedImagePath;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          width: double.infinity,
          child: header.HeaderComponent(),
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
            onTap: () async {
              try {
                final XFile image = await _cameraController!.takePicture();
                setState(() {
                  _isCaptured = true;
                  _capturedImagePath = image.path;
                });
              } catch (e) {
                print('Error capturing image: $e');
              }
            },
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
                'Category',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'B3 (HAZARDOUS WASTE)',
                style: TextStyle(color: Colors.white, fontSize: 18),
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
              });
            },
            child: Text('Scan Again'),
          ),
        ),
      ],
    );
  }
}
