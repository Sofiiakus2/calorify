import 'package:flutter/material.dart';

///food tab
class FoodTab extends StatefulWidget {
  ///constructor
  const FoodTab({
    required TabController tabController,
    super.key,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  final List<String> categories = ["Історія", "Створені",];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget._tabController,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      tabs: categories.map((category) {
        final bool isSelected = categories.indexOf(category)
            == widget._tabController.index;

        return Text(
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
        );
      }).toList(),
    );
  }
}
