import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';

class UrgentPickUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderComponent(),
          Expanded(
            child: Column(
              children: [
                _buildOrderCard(),
                Spacer(),
                Image.asset(
                  'assets/images/bg-urgent.png', // Ganti dengan path gambar yang sesuai
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      padding: EdgeInsets.all(16),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildTextField('Rp.100.000,00'),
          SizedBox(height: 16),
          Text(
            'Payment Method',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildTextField('gopay', prefixIcon: Icons.payment),
          SizedBox(height: 16),
          Text(
            'Time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              onPressed: () {},
              child: Text(
                'Order',
                style: TextStyle(fontSize: 18, color: Colors.white),
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
          value: '08 : 00 - 09 : 00',
          items: [
            DropdownMenuItem(
              value: '08 : 00 - 09 : 00',
              child: Text('08 : 00 - 09 : 00'),
            ),
            DropdownMenuItem(
              value: '09 : 00 - 10 : 00',
              child: Text('09 : 00 - 10 : 00'),
            ),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
