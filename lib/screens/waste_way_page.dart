import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class WasteWayPage extends StatefulWidget {
  const WasteWayPage({Key? key}) : super(key: key);

  @override
  _WasteWayPageState createState() => _WasteWayPageState();
}

class _WasteWayPageState extends State<WasteWayPage> {
  @override
  void initState() {
    super.initState();
    _updateSubscriptionStatus();
  }

  // Menggunakan function checkIsSubscribed() dari ApiService untuk update status
  Future<void> _updateSubscriptionStatus() async {
    await ApiService().checkIsSubscribed();
  }

  Future<void> _handlePickupTap(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isSubscribed = prefs.getBool('is_subscribed') ?? false;
    if (isSubscribed) {
      Navigator.pushNamed(context, '/pickup_schedule');
    } else {
      Navigator.pushNamed(context, '/becomeamember');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/bg-wasteway.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Align(
            alignment: const Alignment(0, -0.62),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
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
                  SizedBox(height: 20),
                  // Drop Off Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/dropoff');
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            'assets/icons/dropoff.png',
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
                  // Pick Up Button with conditional navigation
                  GestureDetector(
                    onTap: () {
                      _handlePickupTap(context);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            'assets/icons/pickup.png',
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
          ),
        ],
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }
}
