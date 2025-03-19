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

  // Update subscription status using checkIsSubscribed() in ApiService.
  Future<void> _updateSubscriptionStatus() async {
    bool subscribed = await ApiService().checkIsSubscribed();
    setState(() {
      _isSubscribed = subscribed;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define scaling factors based on a reference design (height:812, width:375)
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: SafeArea(
        // Wrap content with SingleChildScrollView & ConstrainedBox to support smaller devices.
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: mediaQuery.size.height),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 * scaleWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20 * scaleHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Welcome information with name data from API.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Map<String, dynamic>>(
                            future: ApiService().getUserProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: 24 * scaleHeight,
                                  width: 24 * scaleHeight,
                                  child: const CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 20 * scaleWidth,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF8A6D3B),
                                  ),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data?['success'] == true) {
                                final data = snapshot.data?['data'] ?? {};
                                final userName = data['name'] ?? 'User';
                                return Text(
                                  'Hello $userName',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 24 * scaleWidth,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF8A6D3B),
                                  ),
                                );
                              } else {
                                return Text(
                                  'Hello User',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 24 * scaleWidth,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF8A6D3B),
                                  ),
                                );
                              }
                            },
                          ),
                          // This text will always appear.
                          SizedBox(height: 8 * scaleHeight),
                          Text(
                            'We are going to pick it up',
                            style: GoogleFonts.balooBhai2(
                              fontSize: 16 * scaleWidth,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Right: Subscription status indicator.
                      Column(
                        children: [
                          _isSubscribed == null
                              ? SizedBox(
                                  height: 48 * scaleHeight,
                                  width: 48 * scaleHeight,
                                  child: const CircularProgressIndicator(),
                                )
                              : CircleAvatar(
                                  radius: 24 * scaleWidth,
                                  backgroundColor: _isSubscribed!
                                      ? Colors.green.shade100
                                      : Colors.red.shade100,
                                  child: Icon(
                                    _isSubscribed!
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: _isSubscribed!
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28 * scaleWidth,
                                  ),
                                ),
                          SizedBox(height: 4 * scaleHeight),
                          _isSubscribed == null
                              ? SizedBox(
                                  height: 16 * scaleHeight,
                                  width: 16 * scaleHeight,
                                  child: const CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: _isSubscribed!
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8 * scaleWidth,
                                    vertical: 4 * scaleHeight,
                                  ),
                                  child: Text(
                                    _isSubscribed!
                                        ? 'Subscribed'
                                        : 'Not Subscribed',
                                    style: GoogleFonts.balooBhai2(
                                      color: Colors.white,
                                      fontSize: 12 * scaleWidth,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20 * scaleHeight),
                  Container(
                    padding: EdgeInsets.all(16.0 * scaleWidth),
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
                            fontSize: 20 * scaleWidth,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(height: 8 * scaleHeight),
                        Text(
                          'Your ultimate waste management solution!\nEasily schedule pickups, find drop-off points, scan waste types, and get instant waste solutions.',
                          style: GoogleFonts.balooBhai2(
                            fontSize: 14 * scaleWidth,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20 * scaleHeight),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(16.0 * scaleWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Discover Insights on\nSustainability!',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.balooBhai2(
                                        fontSize: 28 * scaleWidth,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF0C3A2D),
                                      ),
                                    ),
                                    SizedBox(height: 10 * scaleHeight),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add action here when button is clicked
                                        Navigator.pushNamed(
                                            context, '/articles');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6 * scaleWidth,
                                          vertical: 6 * scaleHeight,
                                        ),
                                      ),
                                      child: Text(
                                        'Click To Read More',
                                        style: GoogleFonts.balooBhai2(
                                          fontSize: 14 * scaleWidth,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3 * scaleHeight),
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

                  // -------------------------
                  // CONTOH KOTAK BANNER BARU
                  // -------------------------
                  SizedBox(height: 20 * scaleHeight),
                  // Banner 1
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16 * scaleHeight),
                    padding: EdgeInsets.all(16.0 * scaleWidth),
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/bg-banner-home-2.png', // Ganti dengan path image Anda
                            width: double.infinity,
                            height: 150 * scaleHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 150 * scaleHeight,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Column with left aligned text on top and right aligned button below it.
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0 * scaleWidth),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Redeem Your Points !', // Ganti dengan teks yang diinginkan
                                    style: GoogleFonts.balooBhai2(
                                      color: const Color(0xFF0C3A2D),
                                      fontSize: 20 * scaleWidth,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Get promos & exciting rewards', // Ganti dengan teks yang diinginkan
                                    style: GoogleFonts.balooBhai2(
                                      color: const Color(0xFF0C3A2D),
                                      fontSize: 14 * scaleWidth,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10 * scaleHeight),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add action here when button is clicked
                                    Navigator.pushNamed(context, '/my-points');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // Warna tombol
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2 * scaleWidth,
                                      vertical: 2 * scaleHeight,
                                    ),
                                  ),
                                  child: Text(
                                    'Redeem Now',
                                    style: GoogleFonts.balooBhai2(
                                      color: Colors.white,
                                      fontSize: 12 * scaleWidth,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Extra spacing at the bottom
                  SizedBox(height: 20 * scaleHeight),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
    );
  }
}
