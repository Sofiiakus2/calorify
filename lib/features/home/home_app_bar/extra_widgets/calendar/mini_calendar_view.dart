import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class MiniCalendar extends StatefulWidget {
  final int monthIndex;
  final int year;
  final VoidCallback onTap;
  final DateTime? selectedDay;
  final Function(DateTime) onDaySelected;

  const MiniCalendar({
    Key? key,
    required this.monthIndex,
    required this.year,
    required this.onTap,
    required this.selectedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  State<MiniCalendar> createState() => _MiniCalendarState();
}

class _MiniCalendarState extends State<MiniCalendar> {
  late int today;

  static const List<String> months = [
    'Січень', 'Лютий', 'Березень', 'Квітень', 'Травень', 'Червень',
    'Липень', 'Серпень', 'Вересень', 'Жовтень', 'Листопад', 'Грудень'
  ];

  static const List<String> weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Нд'];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    today = (widget.year == now.year && widget.monthIndex == now.month - 1)
        ? now.day
        : -1;
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(widget.year, widget.monthIndex + 1, 0).day;
    int firstWeekday = DateTime(widget.year, widget.monthIndex + 1, 1).weekday;
    int startOffset = (firstWeekday - 1) % 7;
    Color backgroundColor = lightColors[widget.monthIndex % lightColors.length];

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              months[widget.monthIndex],
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weekDays
                  .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
              ),
              itemCount: daysInMonth + startOffset,
              itemBuilder: (context, index) {
                if (index < startOffset) {
                  return const SizedBox();
                }
                int dayNumber = index - startOffset + 1;
                bool isSelected = widget.selectedDay != null &&
                    widget.selectedDay!.year == widget.year &&
                    widget.selectedDay!.month == widget.monthIndex + 1 &&
                    widget.selectedDay!.day == dayNumber;


                return GestureDetector(
                  onTap: () => widget.onDaySelected(DateTime(widget.year, widget.monthIndex + 1, dayNumber)),
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: isSelected
                          ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      )
                          : null,
                      child: Center(
                        child: Text(
                          '$dayNumber',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: isSelected ? 12 : 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
