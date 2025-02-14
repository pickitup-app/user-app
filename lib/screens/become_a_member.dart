import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class BecomeAMember extends StatefulWidget {
  const BecomeAMember({Key? key}) : super(key: key);

  @override
  _BecomeAMemberState createState() => _BecomeAMemberState();
}

class _BecomeAMemberState extends State<BecomeAMember> {
  int _selectedPaymentMethod =
      -1; // Index opsi payment method yang dipilih (-1 = belum ada yang dipilih)

  // Initialize controllers at the time of declaration.
  final TextEditingController _upcomingChargesController =
      TextEditingController(text: 'Rp150.000');
  final TextEditingController _startingDateController =
      TextEditingController(text: DateTime.now().toString().split(' ')[0]);

  // Controllers for address fields
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _upcomingChargesController.dispose();
    _startingDateController.dispose();
    _streetAddressController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _submitMembership() async {
    setState(() {
      _isLoading = true;
    });
    // Create a data map to send. Populate with field values.
    Map<String, dynamic> data = {
      'street_address': _streetAddressController.text,
      'rt': _rtController.text,
      'rw': _rwController.text,
      'postal_code': _postalCodeController.text,
      'upcoming_charges': _upcomingChargesController.text,
      'starting_date': _startingDateController.text,
      'payment_method': _selectedPaymentMethod,
    };

    // Create an ApiService instance
    final apiService = ApiService();
    final result = await apiService.submitMembership(data);
    setState(() {
      _isLoading = false;
    });
    // The result is a Map; get the success value (expected to be a bool)
    bool success = result["success"] as bool;
    String message = result["message"] as String;

    if (success) {
      // Show snackbar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subscription Successful'),
        ),
      );
      // Navigate to /wasteway
      Navigator.pushNamed(context, '/wasteway');
    } else {
      // Show snackbar with failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subscription Failed: $message'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FCE4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderComponent("Become A Member"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/wp-becomeamember.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
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
                    Text(
                      'Address',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _streetAddressController,
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
                            controller: _rtController,
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
                            controller: _rwController,
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
                      controller: _postalCodeController,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Payment',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Read-only TextFormField for Upcoming Charges
                    TextFormField(
                      controller: _upcomingChargesController,
                      readOnly: true,
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
                    // Read-only TextFormField for Starting Date
                    TextFormField(
                      controller: _startingDateController,
                      readOnly: true,
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
                    Text(
                      'Payment Method',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
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
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitMembership,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        textStyle: GoogleFonts.balooBhai2(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Subscribe'),
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
