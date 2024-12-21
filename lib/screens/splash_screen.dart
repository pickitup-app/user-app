import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/bg-splash.png'), // Path ke gambar "working with tree"
            fit: BoxFit.cover, // Latar belakang memenuhi layar
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.2, // Posisi lebih ke atas
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'images/logo.png', // Path ke logo PU
                  height: 300, // Perbesar ukuran logo
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
