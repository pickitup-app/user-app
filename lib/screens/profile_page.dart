import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import '../services/api_service.dart';
import '../screens/edit_profile.dart'; // Import halaman edit profile

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  // Memuat ulang profil setiap kali halaman dibuka
  Future<void> fetchProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    final apiService = ApiService();
    final result = await apiService.getUserProfile();
    if (result['success'] == true) {
      setState(() {
        profileData = result['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = result['message'] ?? 'Failed to load profile data';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using a constant for additional bottom margin to avoid overlap with navbar
    const double extraBottomMargin = 20.0;

    return Scaffold(
      backgroundColor: Color(0xFFF1FCE4),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: extraBottomMargin),
                  child: Column(
                    children: [
                      // Header Section with Semi-Circle Background
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Color(0xFFF1FCE4),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(200),
                                bottomRight: Radius.circular(200),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 40),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: profileData?['avatar'] != null
                                    ? NetworkImage(profileData!['avatar'])
                                    : AssetImage('assets/images/avatar.png')
                                        as ImageProvider,
                              ),
                              SizedBox(height: 10),
                              Text(
                                profileData?['name'] ?? 'Nama User',
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                profileData?['point'] != null
                                    ? '${profileData!['point'].toString()} points'
                                    : '0 point',
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 50,
                            top: 200,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Image.asset(
                                'assets/icons/tree_left.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 50,
                            top: 200,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Image.asset(
                                'assets/icons/tree_right.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                _InfoSection(
                                  title: 'Personal Information',
                                  icon: Icons.person_outline,
                                  children: [
                                    _buildTextField(
                                        'Full Name', profileData?['name'] ?? '',
                                        readOnly: true),
                                    _buildTextField(
                                        'Email', profileData?['email'] ?? '',
                                        readOnly: true),
                                    _buildTextField(
                                      'Phone Number',
                                      profileData?['phone_number'] != null
                                          ? profileData!['phone_number']
                                              .toString()
                                          : '',
                                      readOnly: true,
                                    ),
                                    _buildTextField('Street Address',
                                        profileData?['street_name'] ?? '',
                                        readOnly: true),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildTextField(
                                            'RT',
                                            profileData?['rt'] != null
                                                ? profileData!['rt'].toString()
                                                : '',
                                            readOnly: true,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: _buildTextField(
                                            'RW',
                                            profileData?['rw'] != null
                                                ? profileData!['rw'].toString()
                                                : '',
                                            readOnly: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    _buildTextField(
                                      'Postal Code',
                                      profileData?['postal_code'] != null
                                          ? profileData!['postal_code']
                                              .toString()
                                          : '',
                                      readOnly: true,
                                    ),
                                    _buildTextField(
                                      'Subscription Status',
                                      profileData?['is_subscribed'] == 1
                                          ? 'Active'
                                          : 'Not Subscribed',
                                      readOnly: true,
                                    ),
                                    _buildTextField(
                                      'Valid Until',
                                      profileData?['subscribed_until'] != null
                                          ? profileData!['subscribed_until']
                                              .toString()
                                          : '',
                                      readOnly: true,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Push the EditProfilePage and await the result.
                                      final updated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilePage()),
                                      );
                                      // If data was updated, reload the profile.
                                      if (updated == true) {
                                        fetchProfile();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.brown,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
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
                                  onPressed: () {
                                    // Insert logout logic if needed
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      'Log Out',
                                      style: GoogleFonts.balooBhai2(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Extra bottom spacer to ensure content is not hidden behind navbar
                      SizedBox(height: extraBottomMargin),
                    ],
                  ),
                ),
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(),
    );
  }

  Widget _buildTextField(String label, String value,
      {bool obscureText = false, bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        obscureText: obscureText,
        readOnly: readOnly,
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
