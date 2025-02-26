import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

class CalendarOverlay extends StatefulWidget {
  const CalendarOverlay({super.key});

  @override
  State<CalendarOverlay> createState() => _CalendarOverlayState();
}

class _CalendarOverlayState extends State<CalendarOverlay> {
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
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return _MiniCalendar(
              monthIndex: index, // 0..11
              onTap: () {
                _showExpandedCalendar(context, index);
              },
            );
          },
        ),
      ),
    );
  }

  void _showExpandedCalendar(BuildContext context, int monthIndex) {
    // Можна показати інший діалог з великим календарем,
    // або змінювати стан, щоби зробити анімацію збільшення на місці.
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: _LargeCalendar(monthIndex: monthIndex),
      ),
    );
  }
}

class _MiniCalendar extends StatelessWidget {
  final int monthIndex;
  final VoidCallback onTap;

  const _MiniCalendar({
    Key? key,
    required this.monthIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: lightPurple,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text('Січень',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

class _LargeCalendar extends StatelessWidget {
  final int monthIndex;

  const _LargeCalendar({Key? key, required this.monthIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Приклад "збільшеного" календаря
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        // Material потрібен, якщо хочете тінь або інші ефекти
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Розгорнутий календар для місяця ${monthIndex + 1}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            // Тут можна додати реальний календар з можливістю обрати дату
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Обрати дату'),
            ),
          ],
        ),
      ),
    );
  }
}