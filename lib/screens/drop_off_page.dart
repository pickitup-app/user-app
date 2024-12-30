import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart'
    as custom_nav; // Import navbar
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class DropOffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderComponent(),
            SizedBox(height: 16),
            // Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Come to Pick It Up",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.balooBhai2(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "for your waste drop-off",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.balooBhai2(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/header-dropoff.png', // Ganti dengan path gambar drop-off
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            SizedBox(height: 24),
            // Maps Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Where Can I Drop Off My Waste?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.balooBhai2(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Map 1
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/maps-1.png'), // Ganti dengan path gambar map 1
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.balooBhai2(
                                fontSize: 12,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      // Map 2
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/maps-2.png'), // Ganti dengan path gambar map 2
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.balooBhai2(
                                fontSize: 12,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Drop-Off Time
                  _buildInfoSection(
                    title: "When Can I Drop Off My Waste?",
                    content:
                        "Drop-off points are open from\n6:00 AM to 3:00 PM\nMake sure to arrive within operating hours.",
                  ),
                  SizedBox(height: 16),
                  // How to Prepare
                  _buildInfoSection(
                    title: "How to Prepare for Drop-Off?",
                    content:
                        "Separate your waste into organic, inorganic, and B3 (hazardous) categories before arriving to speed up the process.",
                  ),
                  SizedBox(height: 16),
                  // Fee Section
                  _buildInfoSection(
                    title: "Is there a fee for dropping off waste?",
                    content:
                        "No, dropping off waste is completely free of charge.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }

  Widget _buildInfoSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.balooBhai2(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          textAlign: TextAlign.center,
          style: GoogleFonts.balooBhai2(
            fontSize: 14,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}
