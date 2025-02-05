import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart';

class BecomeAMember extends StatefulWidget {
  const BecomeAMember({Key? key}) : super(key: key);

  @override
  _BecomeAMemberState createState() => _BecomeAMemberState();
}

class _BecomeAMemberState extends State<BecomeAMember> {
  int _selectedPaymentMethod =
      -1; // Index opsi payment method yang dipilih (-1 = belum ada yang dipilih)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background menggunakan warna dari ProfilePage
      backgroundColor: const Color(0xFFF1FCE4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderComponent("Become A Member"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar header (tidak menggunakan padding)
            Image.asset(
              'assets/images/wp-becomeamember.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            // Container form dengan style yang mengadaptasi desain dari ProfilePage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul halaman dan subjudul
                    Text(
                      'Become a member',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get regular pick up',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Bagian Address
                    Text(
                      'Address',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Street Address',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'RT',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'RW',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Postal Code',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bagian Payment
                    Text(
                      'Payment',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Upcoming Charges',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Starting Date',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bagian Payment Method dengan tampilan grid (2 per baris)
                    Text(
                      'Payment Method',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio:
                          2.5, // Menjadikan sel lebih lebar sehingga tingginya lebih pendek
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _paymentMethodOption('assets/icons/bca-logo-va.png', 0),
                        _paymentMethodOption('assets/icons/ovo-logo-va.png', 1),
                        _paymentMethodOption('assets/icons/gopay-va.png', 2),
                        _paymentMethodOption('assets/icons/spay-va.png', 3),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Tombol Subscribe dengan teks berwarna putih
                    ElevatedButton(
                      onPressed: () {
                        // Logika untuk subscribe
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        textStyle: GoogleFonts.balooBhai2(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Subscribe'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }

  // Widget untuk opsi Payment Method yang dapat diklik (selector)
  Widget _paymentMethodOption(String assetPath, int index) {
    bool isSelected = _selectedPaymentMethod == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 60,
          ),
        ),
      ),
    );
  }
}
