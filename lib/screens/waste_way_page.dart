import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class WasteWayPage extends StatefulWidget {
  const WasteWayPage({Key? key}) : super(key: key);

  @override
  _WasteWayPageState createState() => _WasteWayPageState();
}

class _WasteWayPageState extends State<WasteWayPage> {
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _updateSubscriptionStatus();
  }

  // Update subscription status using the checkIsSubscribed() method from ApiService.
  Future<void> _updateSubscriptionStatus() async {
    bool subscribed = await ApiService().checkIsSubscribed();
    setState(() {
      _isSubscribed = subscribed;
    });
  }

  Future<void> _handlePickupTap(BuildContext context) async {
    // This can use the same check or you can re-read from SharedPreferences.
    final bool isSubscribed = await ApiService().checkIsSubscribed();
    if (isSubscribed) {
      Navigator.pushNamed(context, '/pickup_schedule');
    } else {
      Navigator.pushNamed(context, '/becomeamember');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Compute scaling factors based on a reference design (e.g., height: 812, width: 375)
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    // Compute sizes relative to screen dimensions.
    final double buttonSize = 170 * scaleWidth;
    final double rightOffset = -20 * scaleWidth;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image covering the entire screen.
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/bg-wasteway.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content wrapped in SingleChildScrollView.
            Align(
              alignment: const Alignment(0, -0.62),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: mediaQuery.size.width,
                    minHeight: mediaQuery.size.height * 0.6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30 * scaleHeight),
                      // Header title.
                      Text(
                        "Choose Your\nWaste Way Method",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.balooBhai2(
                          fontSize: 24 * scaleWidth,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      SizedBox(height: 20 * scaleHeight),
                      // Drop Off button.
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/dropoff');
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20 * scaleWidth,
                              vertical: 10 * scaleHeight),
                          padding: EdgeInsets.all(16 * scaleWidth),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
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
                                height: 120 * scaleHeight,
                              ),
                              SizedBox(height: 8 * scaleHeight),
                              Text(
                                "DROP OFF",
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 16 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Pick Up button with conditional navigation.
                      GestureDetector(
                        onTap: () {
                          _handlePickupTap(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20 * scaleWidth,
                              vertical: 10 * scaleHeight),
                          padding: EdgeInsets.all(16 * scaleWidth),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
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
                                height: 120 * scaleHeight,
                              ),
                              SizedBox(height: 8 * scaleHeight),
                              Text(
                                "PICK UP",
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 16 * scaleWidth,
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
            ),
            // Conditionally show the floating button if subscribed.
            if (_isSubscribed)
              Positioned(
                right: rightOffset,
                bottom: -100 + (customNavBarHeight(context) ?? 0),
                width: buttonSize,
                height: buttonSize,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/urgent_pickup');
                  },
                  elevation: 0.0,
                  fillColor: Colors.transparent,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    'assets/images/urgent.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
    );
  }

  double? customNavBarHeight(BuildContext context) {
    return 60.0 * (MediaQuery.of(context).size.width / 375.0);
  }
}
