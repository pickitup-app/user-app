import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class BottomNavigationBar extends StatelessWidget {
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/home.svg',
                  color: Color(0XFF6D9773), // Custom color for Home icon
                  label: 'Home',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                // Waste Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/remove_trash.svg',
                  color: Color(0XFF6D9773), // Custom color for Waste icon
                  label: 'Waste Way',
                  onPressed: () {
                    Navigator.pushNamed(context, '/wasteway');
                  },
                ),
                // Spacer for Floating Button
                SizedBox(width: 48), // Beri ruang untuk FAB
                // Expire Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/chat_exp.svg',
                  color: Color(0XFF6D9773), // Custom color for Expire icon
                  label: 'Expire',
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                // Profile Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/profile.svg',
                  color: Color(0XFF6D9773), // Custom color for Profile icon
                  label: 'Profile',
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
          ),
          // FloatingActionButton in the center
          Positioned(
            top: -20, // Mengatur overflow
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green.shade800,
              child: Icon(Icons.qr_code_scanner, color: Colors.white),
              shape: CircleBorder(), // Ensures the FAB is circular
              elevation:
                  8, // Optional: You can adjust the elevation for a shadow effect
            ),
          ),
        ],
      ),
    );
  }

  // Updated _buildSvgWithText to accept color parameter
  Widget _buildSvgWithText({
    required String svgPath,
    required String label,
    required VoidCallback onPressed,
    required Color color, // New color parameter
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: SvgPicture.asset(
            svgPath,
            width: 24,
            height: 24,
            color: color, // Apply the color to the SVG
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.balooBhai2(
              fontSize: 12, color: Colors.green.shade800),
        ),
      ],
    );
  }
}
