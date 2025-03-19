import 'package:flutter/material.dart';
import 'package:pickitup/services/api_service.dart';
import '../components/header_component.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import '../utils/constants.dart'; // contains apiImages constant

class ClaimRedeemDetailsPage extends StatelessWidget {
  const ClaimRedeemDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve catalog id from route arguments
    final catalogId = ModalRoute.of(context)?.settings.arguments;
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60 * scaleHeight),
        child: HeaderComponent("Voucher Details"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().getSpecificCatalog(catalogId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!['success'] != true) {
            return Center(
              child: Text("Voucher not found."),
            );
          }
          final catalog = snapshot.data!['data'];
          // Build full logo URL using catalog['logo']
          final String logoUrl =
              (catalog['logo'] != null && catalog['logo'] != '')
                  ? "$apiImages/${catalog['logo']}"
                  : "";
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0 * scaleWidth,
                vertical: 16.0 * scaleHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Voucher header section with dynamic logo, title, and points
                  Container(
                    padding: EdgeInsets.all(16.0 * scaleWidth),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30 * scaleWidth,
                          backgroundColor: Colors.green.shade50,
                          backgroundImage:
                              (logoUrl != "") ? NetworkImage(logoUrl) : null,
                          child: (logoUrl == "")
                              ? const Icon(
                                  Icons.image,
                                  color: Colors.green,
                                )
                              : null,
                        ),
                        SizedBox(width: 16 * scaleWidth),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                catalog['title'] ?? 'Voucher Title',
                                style: TextStyle(
                                  fontSize: 20 * scaleWidth,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade900,
                                ),
                              ),
                              SizedBox(height: 8 * scaleHeight),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12 * scaleWidth,
                                  vertical: 6 * scaleHeight,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${catalog['points'] ?? '0'} PTS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14 * scaleWidth,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24 * scaleHeight),
                  // Terms & Conditions
                  Text(
                    "Terms & Conditions:",
                    style: TextStyle(
                      fontSize: 16 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 8 * scaleHeight),
                  Text(
                    catalog['termsandconditions'] ?? "No terms provided.",
                    style: TextStyle(
                      fontSize: 14 * scaleWidth,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24 * scaleHeight),
                  // How To Use
                  Text(
                    "How to Use:",
                    style: TextStyle(
                      fontSize: 16 * scaleWidth,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 8 * scaleHeight),
                  Text(
                    catalog['howtoredeem'] ?? "No instructions provided.",
                    style: TextStyle(
                      fontSize: 14 * scaleWidth,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24 * scaleHeight),
                  // Use Now button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Call the redeemVoucher method with the current catalog id
                        final response =
                            await ApiService().redeemVoucher(catalog['id']);
                        if (response['success'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response['message'] ??
                                  "Voucher redeemed successfully."),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Optionally, navigate to another page or refresh the current page
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response['message'] ??
                                  "Failed to redeem voucher."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 14 * scaleHeight,
                        ),
                      ),
                      child: Text(
                        "Use Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16 * scaleWidth,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
    );
  }
}
