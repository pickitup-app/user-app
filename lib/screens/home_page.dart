import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '../services/api_service.dart'; // Import ApiService

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FutureBuilder untuk menampilkan nama user
                      FutureBuilder<Map<String, String?>>(
                        future: ApiService().getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final userName = snapshot.data?['name'] ?? 'User';
                            return Text(
                              'Hello $userName',
                              style: GoogleFonts.balooBhai2(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8A6D3B),
                              ),
                            );
                          } else {
                            return Text(
                              'Hello User',
                              style: GoogleFonts.balooBhai2(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8A6D3B),
                              ),
                            );
                          }
                        },
                      ),
                      Text(
                        'We are going to pick it up',
                        style: GoogleFonts.balooBhai2(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.green.shade100,
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightGreen.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          'Subscribed',
                          style: GoogleFonts.balooBhai2(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick It Up',
                      style: GoogleFonts.balooBhai2(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your ultimate waste management solution!\nEasily schedule pickups, find drop-off points, scan waste types, and get instant waste solutions.',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // padding: const EdgeInsets.all(
                      //     16.0), // Menambahkan padding untuk kontainer ini
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kontainer untuk teks
                          Container(
                            padding: const EdgeInsets.all(
                                16.0), // Padding untuk teks
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Waste\nOur Responsibility',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0C3A2D),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Explore',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              height: 16), // Jarak antara teks dan gambar

                          // Kontainer untuk gambar
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/bg-home.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }
}
