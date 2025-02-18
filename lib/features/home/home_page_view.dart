import 'package:calorify/features/home/home_app_bar/home_app_bar_view.dart';
import 'package:flutter/material.dart';

import 'calories_chart/calories_chart.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _selectedIndex = 0;
  final List<String> categories = ["Їжа", "Активності", "Вода"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBarView(),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Center(child: CalorieChart()),
                  Positioned(
                      left: 40,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('План',
                              style: Theme.of(context).textTheme.labelSmall),
                          Text('1900 ккал',
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      )
                  ),
                  Positioned(
                      right: 40,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Лишилося',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12)),
                          Text('500 ккал',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16)),
                        ],
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 35,),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryItem(index, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index, BuildContext context) {
    final bool isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          categories[index],
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            foreground: Paint()
              ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.black,
          ),
        ),
      ),
    );
  }
}
