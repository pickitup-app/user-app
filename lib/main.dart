import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:pickitup/screens/become_a_member.dart';
import 'package:pickitup/screens/pickup_schedule.dart';
import 'package:pickitup/screens/profile_page.dart';
import 'package:pickitup/screens/urgent_pickup_page.dart';
import 'package:pickitup/screens/drop_off_page.dart';
import 'package:pickitup/screens/login_page.dart';
import 'package:pickitup/screens/register_page.dart';
import 'package:pickitup/screens/home_page.dart';
import 'package:pickitup/screens/waste_way_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.balooBhai2TextTheme(),
      ),
      initialRoute: '/', // Route awal

      /*
        Routes: Inisialisasi semua yang berkaitan dengan
      */
      routes: {
        '/': (context) => LoginPage(), // Halaman login sebagai default
        '/register': (context) =>
            RegisterPage(), // Halaman login sebagai default
        '/home': (context) => HomePage(), // Halaman setelah login
        '/profile': (context) => ProfilePage(), // Halaman jadwal
        '/wasteway': (context) => WasteWayPage(), // Halaman keanggotaan

        // Halaman jadwal
        '/dropoff': (context) => DropOffPage(), // Halaman drop off
        '/urgentpickup': (context) =>
            UrgentPickUpPage(), // Halaman urgent pickup
        '/pickup_schedule': (context) => PickUpSchedulePage(), // Halaman jadwal
      },
    );
  }
}
