import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

class TooltipIcon extends StatefulWidget {
  @override
  _TooltipIconState createState() => _TooltipIconState();
}

class _TooltipIconState extends State<TooltipIcon> {
  final GlobalKey _toolTipKey = GlobalKey();

  void _showTooltip() {
    final dynamic tooltip = _toolTipKey.currentState;
    tooltip?.ensureTooltipVisible();

    Future.delayed(const Duration(seconds: 1), () {
      tooltip?.deactivate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTooltip,
      child: Tooltip(
        key: _toolTipKey,
        message: 'Для коректного відслідковування рекомендується використовувати смарт годинник',
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 12,
        ),
        decoration: BoxDecoration(
          color: alertBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        padding: const EdgeInsets.all(8),
        preferBelow: false,
        child: const Icon(
          Icons.error_outline,
          color: Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}

