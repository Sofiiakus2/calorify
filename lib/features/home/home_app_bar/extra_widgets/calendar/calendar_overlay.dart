import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'mini_calendar_view.dart';

class CalendarOverlay extends StatefulWidget {
  const CalendarOverlay({super.key});

  @override
  State<CalendarOverlay> createState() => _CalendarOverlayState();
}

class _CalendarOverlayState extends State<CalendarOverlay> {
  DateTime? selectedDay;

  void _onDaySelected(DateTime day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: appMainGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return MiniCalendar(
              monthIndex: index,
              year: 2025,
              selectedDay: selectedDay,
              onDaySelected: _onDaySelected,
              onTap: () {
                // _showExpandedCalendar(context, index);
              },
            );
          },
        ),
      ),
    );
  }
}
