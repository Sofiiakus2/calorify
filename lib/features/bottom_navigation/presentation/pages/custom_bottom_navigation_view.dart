import 'package:calorify/core/provider/bottom_nav_provider.dart';
import 'package:calorify/features/food_page/presentation/pages/food_page.dart';
import 'package:calorify/features/noti_page/presentation/pages/notification_screen.dart';
import 'package:flutter/material.dart';

import 'package:calorify/features/home/presentation/pages/home_page_view.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationView extends StatefulWidget {
  const CustomBottomNavigationView({super.key});

  @override
  State<CustomBottomNavigationView> createState() =>
      _CustomBottomNavigationViewState();
}

class _CustomBottomNavigationViewState
    extends State<CustomBottomNavigationView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageView(),
    const FoodPage(),
    const NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.read<BottomNavProvider>().changeTab(index);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<BottomNavProvider>(context);
    if (provider.currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = provider.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: screenSize.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Image.asset(
                  'assets/icons/filled_rounded_home-512.webp',
                  color: _selectedIndex == 0 ? Colors.white : Colors.black,
                  height: 22,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  Icons.menu_rounded,
                  color: _selectedIndex == 1 ? Colors.white : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  _selectedIndex == 2 ? Icons.notifications : Icons.notifications_none,
                  color: _selectedIndex == 2 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

