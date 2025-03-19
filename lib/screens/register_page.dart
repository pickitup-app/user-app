import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ApiService _apiService = ApiService();

  // Function to validate input fields.
  bool _validateInputs() {
    // Check if any field is empty.
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Semua field harus diisi!')));
      return false;
    }

    // Validate phone number: only digits, 11-13 characters.
    final phoneRegex = RegExp(r'^\d{11,13}$');
    if (!phoneRegex.hasMatch(_phoneController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Nomor telepon harus berupa angka dengan 11-13 digit.')));
      return false;
    }

    // Check if password and confirm password match.
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password tidak cocok!')));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Define scaling factors based on a reference design (e.g., height: 812, width: 375)
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          // Ensure content takes at least the full height even on smaller devices
          constraints: BoxConstraints(minHeight: mediaQuery.size.height),
          child: Container(
            decoration: BoxDecoration(
              // Main background color set to green Color(0xFFF1FCE4)
              color: Color(0xFFF1FCE4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.0 * scaleWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50 * scaleHeight),
                Image.asset('assets/images/logo.png',
                    height: 100 * scaleHeight),
                SizedBox(height: 20 * scaleHeight),
                Image.asset('assets/images/bg-register.png',
                    height: 100 * scaleHeight, fit: BoxFit.contain),
                SizedBox(height: 20 * scaleHeight),
                Text(
                  'Sign Up',
                  style: GoogleFonts.balooBhai2(
                      fontSize: 24 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF6D9773)),
                ),
                SizedBox(height: 8 * scaleHeight),
                Text('Create your account',
                    style: GoogleFonts.balooBhai2(
                        fontSize: 16 * scaleWidth, color: Colors.grey)),
                SizedBox(height: 20 * scaleHeight),
                // Form Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16 * scaleHeight),
                // Form Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16 * scaleHeight),
                // Form Phone Number
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16 * scaleHeight),
                // Form Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16 * scaleHeight),
                // Form Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isConfirmPasswordHidden,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20 * scaleHeight),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF6D9773),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      // Validate input fields.
                      if (!_validateInputs()) {
                        return;
                      }

                      final response = await _apiService.register(
                        _nameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _passwordController.text,
                      );

                      if (response['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registration successful')));
                        Navigator.pushNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response['message'])));
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0 * scaleHeight),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.balooBhai2(
                            fontSize: 16 * scaleWidth,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10 * scaleHeight),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Log in',
                    style: GoogleFonts.balooBhai2(
                        color: Color(0XFF6D9773), fontSize: 16 * scaleWidth),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
