import 'package:flutter/material.dart';

class AnalitikTabBar extends StatefulWidget {
  const AnalitikTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<AnalitikTabBar> createState() => _AnalitikTabBarState();
}

class _AnalitikTabBarState extends State<AnalitikTabBar> {
  final List<String> categories = ["Їжа", "Спорт", "Вода"];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget._tabController,
      isScrollable: false,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      tabs: categories.map((category) {
        final bool isSelected = categories.indexOf(category) == widget._tabController.index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            category,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              overflow: TextOverflow.visible,
              foreground: Paint()
                ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = isSelected
                    ? Colors.black
                    : Colors.grey.withOpacity(0.5),
            ),
          ),
        );
      }).toList(),
    );
  }
}


