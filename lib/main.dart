import 'package:flutter/material.dart';
import 'package:pickitup/screens/drop_off_page.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Mengaktifkan Material Design v3 (Material You)
        textTheme: GoogleFonts.balooBhai2TextTheme(), // Gunakan Google Fonts
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.balooBhai2(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      home: DropOffPage(),
    );
  }
}
