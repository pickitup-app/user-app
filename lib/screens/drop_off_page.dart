import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart'
    as custom_nav; // Import navbar

class DropOffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              color: Color(0xFFF1FCE4), // Light green background
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Aksi tombol back
                    },
                    child: Icon(Icons.arrow_back, color: Colors.brown),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Drop Off",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Come to Pick It Up",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "for your waste drop-off",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Maps Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Where Can I Drop Off My Waste?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
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
                                      'assets/images/map1.png'), // Ganti dengan path gambar map 1
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
                                      'assets/images/map2.png'), // Ganti dengan path gambar map 2
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}
