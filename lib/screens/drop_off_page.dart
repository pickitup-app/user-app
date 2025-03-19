import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart';

class DropOffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtain media query data for responsiveness.
    final mediaQuery = MediaQuery.of(context);
    final scaleWidth = mediaQuery.size.width / 375.0;
    final scaleHeight = mediaQuery.size.height / 812.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: 32.0 * scaleHeight, // extra bottom margin for spacing
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderComponent("Drop Off"),
              SizedBox(height: 16 * scaleHeight),
              // Title Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0 * scaleWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Come to Pick It Up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooBhai2(
                        fontSize: 22 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4 * scaleHeight),
                    Text(
                      "for your waste drop-off",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooBhai2(
                        fontSize: 16 * scaleWidth,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16 * scaleHeight),
              Image.asset(
                'assets/images/header-dropoff.png',
                fit: BoxFit.cover,
                height: 200 * scaleHeight,
                width: double.infinity,
              ),
              SizedBox(height: 24 * scaleHeight),
              // Maps Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0 * scaleWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Where Can I Drop Off My Waste?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooBhai2(
                        fontSize: 18 * scaleWidth,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 16 * scaleHeight),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Map 1
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 120 * scaleHeight,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(8 * scaleWidth),
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/maps-1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8 * scaleHeight),
                              Text(
                                "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 12 * scaleWidth,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16 * scaleWidth),
                        // Map 2
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 120 * scaleHeight,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(8 * scaleWidth),
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/maps-2.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8 * scaleHeight),
                              Text(
                                "Pick It Up Headquarters\nJl. Raya Sentul No. 88,\nRT 02/RW 07, Sentul,\nBabakan Madang, Bogor,\nJawa Barat 16810, Indonesia",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 12 * scaleWidth,
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
              SizedBox(height: 24 * scaleHeight),
              // Information Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0 * scaleWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildInfoSection(
                      context,
                      title: "When Can I Drop Off My Waste?",
                      content:
                          "Drop-off points are open from\n6:00 AM to 3:00 PM\nMake sure to arrive within operating hours.",
                      scaleWidth: scaleWidth,
                      scaleHeight: scaleHeight,
                    ),
                    SizedBox(height: 16 * scaleHeight),
                    _buildInfoSection(
                      context,
                      title: "How to Prepare for Drop-Off?",
                      content:
                          "Separate your waste into organic, inorganic,\nand B3 (hazardous) categories before arriving\nto speed up the process.",
                      scaleWidth: scaleWidth,
                      scaleHeight: scaleHeight,
                    ),
                    SizedBox(height: 16 * scaleHeight),
                    _buildInfoSection(
                      context,
                      title: "Is there a fee for dropping off waste?",
                      content:
                          "No, dropping off waste is completely free of charge.",
                      scaleWidth: scaleWidth,
                      scaleHeight: scaleHeight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(),
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required String content,
    required double scaleWidth,
    required double scaleHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.balooBhai2(
            fontSize: 16 * scaleWidth,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(height: 8 * scaleHeight),
        Text(
          content,
          textAlign: TextAlign.center,
          style: GoogleFonts.balooBhai2(
            fontSize: 14 * scaleWidth,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}
