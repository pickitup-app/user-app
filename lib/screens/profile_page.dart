import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart'
    as custom_nav; // Import navbar
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1FCE4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Semi-Circle Background
            Stack(
              alignment: Alignment.center,
              children: [
                // Large Semi-Circle Background
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1FCE4), // Light green background
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 40),
                    // Profile Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/avatar.png'), // Replace with avatar image
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Charlie Puth',
                      style: GoogleFonts.balooBhai2(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '10000 points',
                      style: GoogleFonts.balooBhai2(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
                // Tree Images Positioned Inside Semi-Circle
                Positioned(
                  left: 50, // Adjust position of left tree
                  top: 200, // Adjust height inside the semi-circle
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      'assets/icons/tree_left.png', // Replace with left tree image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 50, // Adjust position of right tree
                  top: 200, // Adjust height inside the semi-circle
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      'assets/icons/tree_right.png', // Replace with right tree image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Personal Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoSection(
                    title: 'Personal Information',
                    icon: Icons.person_outline,
                    children: [
                      _buildTextField('Full Name', 'Charlie Puth'),
                      _buildTextField('Nick Name', 'Charlie'),
                      _buildTextField('Phone Number', '081234567891'),
                      _buildTextField('Email', 'Charlie.puth@mail.com'),
                      _buildTextField('Password', '********',
                          obscureText: true),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Address Section
                  _InfoSection(
                    title: 'Address',
                    icon: Icons.home_outlined,
                    children: [
                      _buildTextField(
                          'Street Address', 'Jl. Melati Indah No. 42'),
                      Row(
                        children: [
                          Expanded(child: _buildTextField('RT', '02')),
                          SizedBox(width: 16),
                          Expanded(child: _buildTextField('RW', '03')),
                        ],
                      ),
                      _buildTextField('Postal Code', '12430'),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Payment Method Section
                  _InfoSection(
                    title: 'Payment Method',
                    icon: Icons.payment_outlined,
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_balance_wallet_outlined,
                            color: Colors.green.shade800),
                        title: Text('gopay'),
                        tileColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Logout Button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Log Out',
                            style: GoogleFonts.balooBhai2(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Add BottomNavigationBar here
      bottomNavigationBar:
          custom_nav.BottomNavigationBar(), // Menambahkan navbar di bawah
    );
  }

  Widget _buildTextField(String label, String value,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green.shade800),
              SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.balooBhai2(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
