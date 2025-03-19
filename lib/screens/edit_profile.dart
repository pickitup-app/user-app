import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/header_component.dart'; // Pastikan untuk mengimpor HeaderComponent dari file yang sesuai
import '../services/api_service.dart';
import '../components/bottom_navigation_bar.dart' as custom_nav;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String errorMessage = '';
  bool isUpdating = false;

  // Controllers for editable fields
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _streetController;
  late TextEditingController _rtController;
  late TextEditingController _rwController;
  late TextEditingController _postalController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  Future<void> fetchProfile() async {
    final apiService = ApiService();
    final result = await apiService.getUserProfile();
    if (result['success'] == true) {
      setState(() {
        profileData = result['data'];
        isLoading = false;
      });
      _nameController = TextEditingController(text: profileData?['name'] ?? '');
      _phoneController = TextEditingController(
          text: profileData?['phone_number']?.toString() ?? '');
      _streetController =
          TextEditingController(text: profileData?['street_name'] ?? '');
      _rtController =
          TextEditingController(text: profileData?['rt']?.toString() ?? '');
      _rwController =
          TextEditingController(text: profileData?['rw']?.toString() ?? '');
      _postalController = TextEditingController(
          text: profileData?['postal_code']?.toString() ?? '');
    } else {
      setState(() {
        errorMessage = result['message'] ?? 'Failed to load profile data';
        isLoading = false;
      });
    }
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isUpdating = true;
    });
    final apiService = ApiService();
    final data = {
      'name': _nameController.text,
      'phone_number': _phoneController.text,
      'street_name': _streetController.text,
      'rt': _rtController.text,
      'rw': _rwController.text,
      'postal_code': _postalController.text,
    };
    final result = await apiService.updateProfile(data);
    setState(() {
      isUpdating = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'] ?? 'Update failed')),
    );
    if (result['success'] == true) {
      // Return true to indicate that the profile was updated.
      Navigator.pop(context, true);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        validator: validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label must not be empty';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone Number must not be empty';
    }
    final numericRegex = RegExp(r'^\d{11,13}$');
    if (!numericRegex.hasMatch(value.trim())) {
      return 'Phone Number must between 11-13 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1FCE4),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        HeaderComponent("Edit Profile"),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _InfoSection(
                            title: 'Personal Information and Address',
                            icon: Icons.person_outline,
                            children: [
                              _buildTextField(
                                  label: 'Full Name',
                                  controller: _nameController),
                              _buildTextField(
                                  label: 'Phone Number',
                                  controller: _phoneController,
                                  validator: _validatePhoneNumber),
                              _buildTextField(
                                  label: 'Street Address',
                                  controller: _streetController),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                        label: 'RT', controller: _rtController),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTextField(
                                        label: 'RW', controller: _rwController),
                                  ),
                                ],
                              ),
                              _buildTextField(
                                  label: 'Postal Code',
                                  controller: _postalController),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade800,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: isUpdating ? null : _submitUpdate,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: isUpdating
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Text(
                                        'Update',
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
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(),
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
