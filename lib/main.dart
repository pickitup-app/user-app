import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:pickitup/screens/become_a_member.dart';
import 'package:pickitup/screens/pickup_schedule.dart';
import 'package:pickitup/screens/urgent_pickup_page.dart';
import 'package:pickitup/screens/drop_off_page.dart';
import 'package:pickitup/screens/login_page.dart';

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
        '/home': (context) => UrgentPickUpPage(), // Halaman setelah login
        '/schedule': (context) => PickUpSchedulePage(), // Halaman jadwal
        '/member': (context) => BecomeAMember(), // Halaman keanggotaan
        '/dropoff': (context) => DropOffPage(), // Halaman drop off
      },
    );
  }
}
