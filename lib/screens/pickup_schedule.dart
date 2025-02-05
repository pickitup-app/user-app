import 'package:flutter/material.dart';
import 'package:pickitup/components/bottom_navigation_bar.dart' as custom_nav;
import 'package:pickitup/components/header_component.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class PickUpSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderComponent("Pick Up Schedule"),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildNextPickUpSection(),
                _buildScheduleTab(),
                _buildTimelineItem(
                  isCompleted: true,
                  child: _buildPickUpItem(
                    date: 'Sunday, 10 November 2024',
                    time: '05:00-06:00',
                    isCompleted: true,
                  ),
                ),
                _buildTimelineItem(
                  child: _buildPickUpItem(
                    date: 'Tuesday, 12 November 2024',
                    time: '05:00-06:00',
                  ),
                ),
                _buildTimelineItem(
                  child: _buildPickUpItem(
                    date: 'Thursday, 14 November 2024',
                    time: '05:00-06:00',
                  ),
                ),
                _buildTimelineItem(
                  child: _buildPickUpItem(
                    date: 'Saturday, 16 November 2024',
                    time: '05:00-06:00',
                  ),
                ),
                _buildTimelineItem(
                  child: _buildPickUpItem(
                    date: 'Sunday, 17 November 2024',
                    time: '05:00-06:00',
                    isUrgent: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: custom_nav.BottomNavigationBar(),
    );
  }

  Widget _buildNextPickUpSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: Colors.green.shade800),
        title: Text(
          'Next Pick Up',
          style:
              GoogleFonts.balooBhai2(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Monday, 11 November 2024',
          style: GoogleFonts.balooBhai2(color: Colors.green.shade800),
        ),
      ),
    );
  }

  Widget _buildScheduleTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Schedule',
              style: GoogleFonts.balooBhai2(
                  fontWeight: FontWeight.bold, color: Colors.green.shade800)),
          Text('Ongoing', style: GoogleFonts.balooBhai2(color: Colors.grey)),
          Text('History', style: GoogleFonts.balooBhai2(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({required Widget child, bool isCompleted = false}) {
    return Row(
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
                            color: isCompleted
                                ? Colors.green
                                : Colors.grey.shade300,
                          ),
                        ),
                      )),
            ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildPickUpItem({
    required String date,
    required String time,
    bool isCompleted = false,
    bool isUrgent = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.event,
              color: isCompleted ? Colors.white : Colors.green.shade800),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCompleted ? 'Picked Up Today' : 'Scheduled Pick Up',
                  style: GoogleFonts.balooBhai2(
                    color: isCompleted ? Colors.white : Colors.green.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.balooBhai2(
                    color: isCompleted ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.balooBhai2(
                    color: isCompleted ? Colors.white : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          if (isUrgent)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'URGENT',
                style: GoogleFonts.balooBhai2(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
