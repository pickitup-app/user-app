import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  // Function to process login
  void _login() async {
    // Validate input
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Call API for login
    final response = await ApiService().login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      // Navigate to home page on successful login
      Navigator.pushNamed(context, '/home');
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Login failed')),
      );
    }
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
          // Ensure content takes at least full height even on smaller devices
          constraints: BoxConstraints(
            minHeight: mediaQuery.size.height,
          ),
          child: Container(
            // Main background color set to green Color(0xFFF1FCE4)
            decoration: BoxDecoration(
              color: Color(0xFFF1FCE4),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0 * scaleWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50 * scaleHeight),
                  Image.asset('assets/images/logo.png',
                      height: 100 * scaleHeight),
                  SizedBox(height: 20 * scaleHeight),
                  Image.asset('assets/images/recycle_truck.png',
                      height: 200 * scaleHeight),
                  SizedBox(height: 20 * scaleHeight),
                  Text(
                    'Log in',
                    style: GoogleFonts.balooBhai2(
                      fontSize: 24 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF6D9773),
                    ),
                  ),
                  SizedBox(height: 8 * scaleHeight),
                  Text(
                    'Enter Your Account',
                    style: GoogleFonts.balooBhai2(
                      fontSize: 16 * scaleWidth,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20 * scaleHeight),
                  // Email Form Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16 * scaleHeight),
                  // Password Form Field
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
                  SizedBox(height: 10 * scaleHeight),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password',
                      style:
                          GoogleFonts.balooBhai2(color: Colors.green.shade800),
                    ),
                  ),
                  SizedBox(height: 20 * scaleHeight),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF6D9773),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0 * scaleHeight),
                              child: Text(
                                'Log In',
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 16 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10 * scaleHeight),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.balooBhai2(
                        color: Color(0XFF6D9773),
                        fontSize: 16 * scaleWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
