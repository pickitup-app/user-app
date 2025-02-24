import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class UrgentPickUpPage extends StatefulWidget {
  @override
  _UrgentPickUpPageState createState() => _UrgentPickUpPageState();
}

class _UrgentPickUpPageState extends State<UrgentPickUpPage> {
  // Variabel untuk menampung nilai time slot yang dipilih.
  String _selectedTimeSlot = '08 : 00 - 09 : 00';
  final ApiService apiService = ApiService();

  void _submitOrder() async {
    // Memanggil fungsi submitUrgentPickup pada ApiService dan menunggu responnya.
    final result = await apiService.submitUrgentPickup(_selectedTimeSlot);
    // Menampilkan response message dari laravel.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'] ?? 'No message returned')),
    );
    // Jika berhasil, navigasi ke /wasteway
    if (result['success'] == true) {
      Navigator.pushNamed(context, '/wasteway');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderComponent("Urgent Pick-Up"),
          Expanded(
            child: Column(
              children: [
                _buildOrderCard(),
                Spacer(),
                Image.asset(
                  'assets/images/bg-urgent.png',
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price',
            style: GoogleFonts.balooBhai2(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          _buildTextField('Rp.100.000,00'),
          SizedBox(height: 16),
          Text(
            'Payment Method',
            style: GoogleFonts.balooBhai2(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          _buildTextField(
            'gopay',
            prefixIcon: Icons.payment,
          ),
          SizedBox(height: 16),
          Text(
            'Time',
            style: GoogleFonts.balooBhai2(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          _buildDropdownField(),
          SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              onPressed: _submitOrder,
              child: Text(
                'Order',
                style: GoogleFonts.balooBhai2(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String text, {IconData? prefixIcon}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: text,
      ),
      readOnly: true,
    );
  }

  Widget _buildDropdownField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedTimeSlot,
          items: [
            DropdownMenuItem(
              value: '08 : 00 - 09 : 00',
              child: Text('08 : 00 - 09 : 00'),
            ),
            DropdownMenuItem(
              value: '09 : 00 - 10 : 00',
              child: Text('09 : 00 - 10 : 00'),
            ),
            DropdownMenuItem(
              value: '10 : 00 - 11 : 00',
              child: Text('10 : 00 - 11 : 00'),
            ),
            DropdownMenuItem(
              value: '13 : 00 - 14 : 00',
              child: Text('13 : 00 - 14 : 00'),
            ),
            DropdownMenuItem(
              value: '14 : 00 - 15 : 00',
              child: Text('14 : 00 - 15 : 00'),
            ),
            DropdownMenuItem(
              value: '15 : 00 - 16 : 00',
              child: Text('15 : 00 - 16 : 00'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedTimeSlot = value;
              });
            }
          },
        ),
      ),
    );
  }
}
