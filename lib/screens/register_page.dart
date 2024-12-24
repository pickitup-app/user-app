import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1FCE4), // Background color sesuai desain
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              // Logo PU
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              SizedBox(height: 20),
              // Gambar truk
              Image.asset(
                'assets/images/recycle_truck.png', // Path ke gambar truk
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              // Form Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Form Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Form Phone Number
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Form Password
              TextFormField(
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
              SizedBox(height: 16),
              // Form Confirm Password
              TextFormField(
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
              SizedBox(height: 20),
              // Sign Up Button
              SizedBox(
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
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Log in',
                  style: TextStyle(color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
