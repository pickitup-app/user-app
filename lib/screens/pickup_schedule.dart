import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:pickitup/services/api_service.dart';

class PickUpSchedulePage extends StatefulWidget {
  @override
  _PickUpSchedulePageState createState() => _PickUpSchedulePageState();
}

class _PickUpSchedulePageState extends State<PickUpSchedulePage> {
  final ApiService _apiService = ApiService();

  // Tab indices:
  // 0 - Scheduled (orders for today and after today)
  // 1 - Ongoing (orders for today only with tracks timeline)
  // 2 - History (orders before today)
  int _selectedTabIndex = 0;

  Future<List<dynamic>> _fetchOrders() async {
    try {
      final response = await _apiService.getUserOrders();
      if (response['success'] == true && response['data'] != null) {
        return List<dynamic>.from(response['data']);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Fetch tracks for a given order by calling ApiService.getTracks.
  Future<List<dynamic>> _fetchTracks(int orderId) async {
    try {
      final response = await _apiService.getTracks({'order_id': orderId});
      if (response['success'] == true && response['data'] != null) {
        List<dynamic> tracks = List<dynamic>.from(response['data']);
        // Sort tracks from newest to oldest using created_at
        tracks.sort((a, b) => DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at'])));
        return tracks;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  bool _isOrderCompleted(Map<String, dynamic> order) {
    if (order.containsKey('status') &&
        order['status'] != null &&
        order['status'].toString().toLowerCase() == 'completed') {
      return true;
    }
    if (order.containsKey('accepted_at') && order['accepted_at'] != null) {
      return true;
    }
    return false;
  }

  // Convert dynamic "is_urgent" value into a bool.
  bool _convertToBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    return false;
  }

  // Parse the order date based on possible formats.
  DateTime? _parseOrderDate(String dateStr) {
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      try {
        final formatter = DateFormat("EEEE, dd MMMM yyyy");
        return formatter.parse(dateStr);
      } catch (e) {
        return null;
      }
    }
  }

  // Determine the background color based on order date.
  Color _getBackgroundColor(String orderDate) {
    DateTime? dt = _parseOrderDate(orderDate);
    if (dt != null) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime orderDay = DateTime(dt.year, dt.month, dt.day);
      if (orderDay.isAtSameMomentAs(today)) {
        return Colors.green.shade800;
      } else if (orderDay.isBefore(today)) {
        return Colors.grey.shade400;
      }
    }
    return Colors.white;
  }

  // Decide text color based on background.
  Color _getTextColor(Color backgroundColor) {
    return backgroundColor == Colors.white
        ? Colors.green.shade800
        : Colors.white;
  }

  // Filter orders based on the selected tab.
  List<dynamic> _filterOrders(List<dynamic> orders) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return orders.where((order) {
      String dateStr = order['order_date'] ?? '';
      DateTime? dt = _parseOrderDate(dateStr);
      if (dt == null) return false;
      DateTime orderDay = DateTime(dt.year, dt.month, dt.day);
      if (_selectedTabIndex == 0) {
        // Scheduled: orders for today or after today.
        return orderDay.isAtSameMomentAs(today) || orderDay.isAfter(today);
      } else if (_selectedTabIndex == 1) {
        // Ongoing: orders for today only.
        return orderDay.isAtSameMomentAs(today);
      } else if (_selectedTabIndex == 2) {
        // History: orders before today.
        return orderDay.isBefore(today);
      }
      return false;
    }).toList();
  }

  // Custom tabs
  Widget _buildScheduleTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem("Scheduled", 0),
          _buildTabItem("Ongoing", 1),
          _buildTabItem("History", 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Text(
        title,
        style: GoogleFonts.balooBhai2(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.green.shade800 : Colors.grey,
        ),
      ),
    );
  }

  // Generic timeline item widget.
  Widget _buildTimelineItem({required Widget child, bool isCompleted = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.green : Colors.grey,
                ),
              ),
              Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isCompleted ? Colors.green : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
  }

  // Main pick up item widget.
  Widget _buildPickUpItem(
      {required String date, required String time, bool isUrgent = false}) {
    Color backgroundColor = _getBackgroundColor(date);
    Color textColor = _getTextColor(backgroundColor);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.event, color: textColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  backgroundColor == Colors.green.shade800
                      ? 'Picked Up Today'
                      : 'Scheduled Pick Up',
                  style: GoogleFonts.balooBhai2(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(date, style: GoogleFonts.balooBhai2(color: textColor)),
                Text(time, style: GoogleFonts.balooBhai2(color: textColor)),
              ],
            ),
          ),
          if (isUrgent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'URGENT',
                style: GoogleFonts.balooBhai2(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget to display tracks timeline for a given order.
  Widget _buildTracksTimeline(int orderId) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchTracks(orderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: Text('Error loading tracks')),
          );
        }
        final tracks = snapshot.data ?? [];
        if (tracks.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: Text('No tracks available.')),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header for tracks.
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                'Tracks',
                style: GoogleFonts.balooBhai2(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Column(
              children: tracks.map((track) {
                String createdAt = track['created_at'] ?? '';
                String status = track['status'] ?? 'Unknown';
                return _buildTimelineItem(
                  isCompleted: status.toLowerCase() == 'completed',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: GoogleFonts.balooBhai2(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                        Text(
                          'Created at: $createdAt',
                          style: GoogleFonts.balooBhai2(
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderComponent("Pick Up Schedule"),
            _buildScheduleTab(),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No pick up orders available.'));
                  }
                  final orders = _filterOrders(snapshot.data!);
                  if (orders.isEmpty) {
                    return Center(
                      child: Text(
                        _selectedTabIndex == 2
                            ? 'No history orders available.'
                            : 'No upcoming orders available.',
                        style: GoogleFonts.balooBhai2(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: orders.map((order) {
                      // Build primary order timeline item.
                      List<Widget> orderWidgets = [
                        _buildTimelineItem(
                          isCompleted: _isOrderCompleted(order),
                          child: _buildPickUpItem(
                            date: order['order_date'] ?? 'No date available',
                            time: (order.containsKey('time') &&
                                    order['time'] != null)
                                ? order['time']
                                : 'Scheduled',
                            isUrgent: _convertToBool(order['is_urgent']),
                          ),
                        ),
                      ];
                      // For Ongoing tab, append the tracks timeline below the order item.
                      if (_selectedTabIndex == 1) {
                        orderWidgets.add(_buildTracksTimeline(order['id']));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orderWidgets,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }
}
