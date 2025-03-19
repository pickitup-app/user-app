import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  // Helper method to navigate only if the target route is not the current one.
  // For smoother animations, define custom route transitions on MaterialApp.onGenerateRoute.
  void _safeNavigate(BuildContext context, String routeName) {
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
                  context: context,
                  svgPath: 'assets/icons/home.svg',
                  color: const Color(0XFF6D9773), // Custom color for Home icon
                  label: 'Home',
                  onPressed: () {
                    _safeNavigate(context, '/home');
                  },
                ),
                // Waste Icon with Text
                _buildSvgWithText(
                  context: context,
                  svgPath: 'assets/icons/remove_trash.svg',
                  color: const Color(0XFF6D9773), // Custom color for Waste icon
                  label: 'Waste Way',
                  onPressed: () {
                    _safeNavigate(context, '/wasteway');
                  },
                ),
                // Spacer for Floating Button
                const SizedBox(width: 48), // Reserve space for the FAB
                // Expire Icon with Text (e.g., for Chat)
                _buildSvgWithText(
                  context: context,
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
                  context: context,
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
            top: -10, // Adjust overflow as needed
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {
                _safeNavigate(context, '/scan');
              },
              backgroundColor: const Color(0xFF6D9773),
              child: const Icon(Icons.qr_code_scanner, color: Colors.white),
              shape: const CircleBorder(), // Ensures the FAB is circular
              elevation: 8, // Adjust elevation for a shadow effect
            ),
          ),
        ],
      ),
    );
  }

  // Wrap the icon and text together in an InkWell to expand the hit area; both icon and text will have tap effects.
  Widget _buildSvgWithText({
    required BuildContext context,
    required String svgPath,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(32),
      child: Padding(
        padding: const EdgeInsets.all(3.0), // Increase overall touch area
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              color: color,
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
        ),
      ),
    );
  }
}
