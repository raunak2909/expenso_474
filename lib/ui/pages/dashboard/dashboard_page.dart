import 'package:flutter/material.dart';

import 'nav_pages/chart_nav_page.dart';
import 'nav_pages/home_nav_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> mNavPages = [
    HomeNavPage(),
    ChartNavPage(),
  ];

  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mNavPages[selectedNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          selectedNavIndex = value;
          setState(() {

          });
        },
          currentIndex: selectedNavIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30, color: Colors.grey.shade400),
                label: "Home",
                activeIcon: Icon(Icons.home, color: Colors.pink.shade200, size: 30,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined, size: 30, color: Colors.grey.shade400),
                label: "Chart",
                activeIcon: Icon(Icons.bar_chart, color: Colors.pink.shade200, size: 30,)
            )
          ]
      ),

    );
  }
}
