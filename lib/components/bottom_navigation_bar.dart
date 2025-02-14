import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);

  // Helper method to navigate only if the target route is not the current one.
  // Untuk animasi yang lebih halus, pastikan custom route transition didefinisikan pada MaterialApp.onGenerateRoute.
  void _safeNavigate(BuildContext context, String routeName) {
    // Cek nama route saat ini, jika sama dengan route tujuan maka tidak melakukan navigasi.
    if (ModalRoute.of(context)?.settings.name == routeName) return;
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
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
                  color: const Color(0XFF6D9773), // Custom color for Home icon
                  label: 'Home',
                  onPressed: () {
                    _safeNavigate(context, '/home');
                  },
                ),
                // Waste Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/remove_trash.svg',
                  color: const Color(0XFF6D9773), // Custom color for Waste icon
                  label: 'Waste Way',
                  onPressed: () {
                    _safeNavigate(context, '/wasteway');
                  },
                ),
                // Spacer for Floating Button
                const SizedBox(width: 48), // Beri ruang untuk FAB
                // Expire Icon with Text (misal untuk Chat)
                _buildSvgWithText(
                  svgPath: 'assets/icons/chat_exp.svg',
                  color:
                      const Color(0XFF6D9773), // Custom color for Expire icon
                  label: 'Expire',
                  onPressed: () {
                    _safeNavigate(context, '/chat');
                  },
                ),
                // Profile Icon with Text
                _buildSvgWithText(
                  svgPath: 'assets/icons/profile.svg',
                  color:
                      const Color(0XFF6D9773), // Custom color for Profile icon
                  label: 'Profile',
                  onPressed: () {
                    _safeNavigate(context, '/profile');
                  },
                ),
              ],
            ),
          ),
          // FloatingActionButton in the center
          Positioned(
            top: -10, // Mengatur overflow
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {
                _safeNavigate(context, '/scan');
              },
              backgroundColor: const Color(0xFF6D9773),
              child: const Icon(Icons.qr_code_scanner, color: Colors.white),
              shape: const CircleBorder(), // Ensures the FAB is circular
              elevation: 8, // Optional: Adjust elevation for shadow effect
            ),
          ),
        ],
      ),
    );
  }

  // _buildSvgWithText now uses a Stack with a Positioned GestureDetector that extends the hit area
  // without changing the visible icon size.
  Widget _buildSvgWithText({
    required String svgPath,
    required String label,
    required VoidCallback onPressed,
    required Color color, // New color parameter
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              color: color, // Apply the color to the SVG
            ),
            // Expand the touchable area by positioning a transparent GestureDetector outside the icon's bounds.
            Positioned(
              left: -12,
              top: -12,
              right: -12,
              bottom: -12,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.balooBhai2(
            fontSize: 12,
            color: const Color(0xFF6D9773),
          ),
        ),
      ],
    );
  }
}
