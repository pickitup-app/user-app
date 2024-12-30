import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart'
    as custom_nav; // Import navbar

class WasteWayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/icons/bg-wasteway.png'), // Ganti dengan path gambar background
                fit: BoxFit.cover, // Background memenuhi layar
              ),
            ),
          ),
          // Content
          Center(
            // Gunakan Center untuk menempatkan elemen di tengah
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Minimize space to center content vertically
              children: [
                SizedBox(height: 50), // Spasi untuk header
                // Header Title
                Text(
                  "Choose Your\nWaste Way Method",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooBhai2(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                SizedBox(height: 40),
                // Drop Off Button
                GestureDetector(
                  onTap: () {
                    // Aksi saat tombol Drop Off ditekan
                    Navigator.pushNamed(context, '/dropoff');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/dropoff.png', // Ganti dengan path gambar Drop Off
                          height: 120,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "DROP OFF",
                          style: GoogleFonts.balooBhai2(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Pick Up Button
                GestureDetector(
                  onTap: () {
                    // Aksi saat tombol Pick Up ditekan
                    Navigator.pushNamed(context, '/pickup_schedule');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/pickup.png', // Ganti dengan path gambar Pick Up
                          height: 120,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "PICK UP",
                          style: GoogleFonts.balooBhai2(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }
}
