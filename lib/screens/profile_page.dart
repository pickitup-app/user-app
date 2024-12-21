import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          // Profile Avatar
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'images/profile_avatar.png'), // Replace with your avatar image
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Charlie Puth',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '10000 points',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Personal Information Section
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
                              style: TextStyle(
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
            ),
          ),
          // Bottom Navigation Bar
          CustomBottomNavigationBar(),
        ],
      ),
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
                style: TextStyle(
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

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, color: Colors.green.shade800),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.green.shade800),
            onPressed: () {},
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green.shade800,
            child: Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.chat_outlined, color: Colors.green.shade800),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outlined, color: Colors.green.shade800),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
