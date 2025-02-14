import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? _isSubscribed;

  @override
  void initState() {
    super.initState();
    _updateSubscriptionStatus();
  }

  // Menggunakan method checkIsSubscribed() yang sudah ada di api_service.dart
  Future<void> _updateSubscriptionStatus() async {
    bool subscribed = await ApiService().checkIsSubscribed();
    setState(() {
      _isSubscribed = subscribed;
    });
  }

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
                  // Kiri: Informasi selamat datang dan data user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, String?>>(
                        future: ApiService().getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final userName = snapshot.data?['name'] ?? 'User';
                            return Text(
                              'Hello $userName',
                              style: GoogleFonts.balooBhai2(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF8A6D3B),
                              ),
                            );
                          } else {
                            return Text(
                              'Hello User',
                              style: GoogleFonts.balooBhai2(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF8A6D3B),
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
                  // Kanan: Indikator status subscription
                  Column(
                    children: [
                      _isSubscribed == null
                          ? SizedBox(
                              height: 48,
                              width: 48,
                              child: CircularProgressIndicator(),
                            )
                          : CircleAvatar(
                              radius: 24,
                              backgroundColor: _isSubscribed!
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              child: Icon(
                                _isSubscribed!
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    _isSubscribed! ? Colors.green : Colors.red,
                              ),
                            ),
                      const SizedBox(height: 4),
                      _isSubscribed == null
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color:
                                    _isSubscribed! ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                _isSubscribed!
                                    ? 'Subscribed'
                                    : 'Not Subscribed',
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
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your ultimate waste management solution!\nEasily schedule pickups, find drop-off points, scan waste types, and get instant waste solutions.',
                      style: GoogleFonts.balooBhai2(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Waste\nOur Responsibility',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF0C3A2D),
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
                          const SizedBox(height: 16),
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
      bottomNavigationBar: const custom_nav.BottomNavigationBar(),
    );
  }
}
