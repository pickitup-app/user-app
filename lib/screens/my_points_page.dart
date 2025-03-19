import 'package:flutter/material.dart';
import '../components/header_component.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/services/api_service.dart';
import '../utils/constants.dart'; // contains apiImages constant

class MyPointsPage extends StatelessWidget {
  const MyPointsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaling for responsive design
    final mediaQuery = MediaQuery.of(context);
    final scaleHeight = mediaQuery.size.height / 812.0;
    final scaleWidth = mediaQuery.size.width / 375.0;

    return DefaultTabController(
      length: 3, // Redeem, My Rewards, History
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade50,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60 * scaleHeight),
          child: HeaderComponent("My Points"),
        ),
        body: Column(
          children: [
            // Total Earning Points Section using FutureBuilder to get user points
            FutureBuilder<Map<String, dynamic>>(
              future: ApiService().getUserPoint(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('[MyPointsPage] Loading user point...');
                }
                if (snapshot.hasError) {
                  print('[MyPointsPage] Error: ${snapshot.error}');
                }
                String points = "0 PTS";
                if (snapshot.hasData && snapshot.data!['success'] == true) {
                  points = "${snapshot.data!['data']['point']} PTS";
                  print(
                      '[MyPointsPage] User point fetched: ${snapshot.data!['data']['point']}');
                } else {
                  print('[MyPointsPage] No valid data for user point.');
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * scaleWidth,
                    vertical: 16.0 * scaleHeight,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0 * scaleWidth),
                    decoration: BoxDecoration(
                      color: Color(0XFF0C3A2D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Total Earning Point",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16 * scaleWidth,
                          ),
                        ),
                        SizedBox(height: 8 * scaleHeight),
                        Text(
                          points,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28 * scaleWidth,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Tab Bar Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16.0 * scaleWidth),
              child: const TabBar(
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Redeem'),
                  Tab(text: 'My Rewards'),
                  Tab(text: 'History'),
                ],
              ),
            ),
            SizedBox(height: 16 * scaleHeight),
            // Tab Views with FutureBuilders
            Expanded(
              child: TabBarView(
                children: [
                  // Redeem Tab: using getCatalogs()
                  FutureBuilder<List<dynamic>>(
                    future: ApiService().getCatalogs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('[MyPointsPage] Loading Redeem catalogs...');
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print(
                            '[MyPointsPage] Error in Redeem catalogs: ${snapshot.error}');
                      }
                      final catalogs = snapshot.data ?? [];
                      print('[MyPointsPage] Redeem catalogs: $catalogs');
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0 * scaleWidth,
                          vertical: 16.0 * scaleHeight,
                        ),
                        itemCount: catalogs.length,
                        itemBuilder: (context, index) {
                          final catalog = catalogs[index];
                          // Cek apakah terdapat properti catalog (nested)
                          final displayData = catalog.containsKey('catalog')
                              ? catalog['catalog']
                              : catalog;
                          final String logoUrl = (displayData['logo'] != null &&
                                  displayData['logo'] != '')
                              ? "$apiImages/${displayData['logo']}"
                              : "";
                          return _buildVoucherCard(
                            context,
                            scaleWidth,
                            scaleHeight,
                            logoUrl: logoUrl,
                            title: displayData['title'] ?? 'Untitled Voucher',
                            description: displayData['description'] ?? '',
                            showRedeemButton: true,
                            catalogId: catalog['id'],
                          );
                        },
                      );
                    },
                  ),
                  // My Rewards Tab: filtering getCatalogsUser() by is_redeemed == 0
                  FutureBuilder<List<dynamic>>(
                    future: ApiService().getCatalogsUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('[MyPointsPage] Loading My Rewards catalogs...');
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print(
                            '[MyPointsPage] Error in My Rewards catalogs: ${snapshot.error}');
                      }
                      final allCatalogs = snapshot.data ?? [];
                      print(
                          '[MyPointsPage] All catalogs from user: $allCatalogs');
                      final catalogs = allCatalogs
                          .where((catalog) =>
                              catalog['is_redeemed'].toString() == '0')
                          .toList();
                      print(
                          '[MyPointsPage] Filtered My Rewards catalogs: $catalogs');
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0 * scaleWidth,
                          vertical: 16.0 * scaleHeight,
                        ),
                        itemCount: catalogs.length,
                        itemBuilder: (context, index) {
                          final catalog = catalogs[index];
                          final displayData = catalog.containsKey('catalog')
                              ? catalog['catalog']
                              : catalog;
                          final String logoUrl = (displayData['logo'] != null &&
                                  displayData['logo'] != '')
                              ? "$apiImages/${displayData['logo']}"
                              : "";
                          return _buildVoucherCard(
                            context,
                            scaleWidth,
                            scaleHeight,
                            logoUrl: logoUrl,
                            title: displayData['title'] ?? 'Untitled Voucher',
                            description: displayData['description'] ?? '',
                            showRedeemButton: false,
                            catalogId: catalog['id'],
                          );
                        },
                      );
                    },
                  ),
                  // History Tab: filtering getCatalogsUser() by is_redeemed == 1
                  FutureBuilder<List<dynamic>>(
                    future: ApiService().getCatalogsUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('[MyPointsPage] Loading History catalogs...');
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print(
                            '[MyPointsPage] Error in History catalogs: ${snapshot.error}');
                      }
                      final allCatalogs = snapshot.data ?? [];
                      print(
                          '[MyPointsPage] All catalogs from user: $allCatalogs');
                      final catalogs = allCatalogs
                          .where((catalog) =>
                              catalog['is_redeemed'].toString() == '1')
                          .toList();
                      print(
                          '[MyPointsPage] Filtered History catalogs: $catalogs');
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0 * scaleWidth,
                          vertical: 16.0 * scaleHeight,
                        ),
                        itemCount: catalogs.length,
                        itemBuilder: (context, index) {
                          final catalog = catalogs[index];
                          final displayData = catalog.containsKey('catalog')
                              ? catalog['catalog']
                              : catalog;
                          final String logoUrl = (displayData['logo'] != null &&
                                  displayData['logo'] != '')
                              ? "$apiImages/${displayData['logo']}"
                              : "";
                          return _buildVoucherCard(
                            context,
                            scaleWidth,
                            scaleHeight,
                            logoUrl: logoUrl,
                            title: displayData['title'] ?? 'Untitled Voucher',
                            description: displayData['description'] ?? '',
                            showRedeemButton: false,
                            catalogId: catalog['id'],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const custom_nav.CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildVoucherCard(
    BuildContext context,
    double scaleWidth,
    double scaleHeight, {
    required String logoUrl,
    required String title,
    required String description,
    required bool showRedeemButton,
    required dynamic catalogId,
  }) {
    return Container(
      padding: EdgeInsets.all(12.0 * scaleWidth),
      margin: EdgeInsets.only(bottom: 12.0 * scaleHeight),
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
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24 * scaleWidth,
                backgroundColor: Colors.green.shade50,
                backgroundImage: (logoUrl != "") ? NetworkImage(logoUrl) : null,
                child: (logoUrl == "")
                    ? const Icon(
                        Icons.image,
                        color: Colors.green,
                      )
                    : null,
              ),
              SizedBox(width: 12 * scaleWidth),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16 * scaleWidth,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4 * scaleHeight),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12 * scaleWidth,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showRedeemButton)
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  print("Navigating with catalogId: $catalogId");
                  Navigator.pushNamed(context, '/claim-redeem',
                      arguments: catalogId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * scaleWidth,
                    vertical: 6 * scaleHeight,
                  ),
                ),
                child: Text(
                  "Redeem",
                  style: TextStyle(
                    fontSize: 12 * scaleWidth,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
