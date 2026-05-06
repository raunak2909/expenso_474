import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/app_routes.dart';
import '../add_expense/bloc/expense_bloc.dart';
import '../add_expense/bloc/expense_event.dart';
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
    ChartNavPage(),
    ChartNavPage(),
    ChartNavPage(),
  ];

  int selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mNavPages[selectedNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value){
          if(value==2){
            Navigator.pushNamed(context, AppRoutes.ADD_EXPENSE_ROUTE);
          } else {
            selectedNavIndex = value;
            setState(() {

            });
          }
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
            ),
            BottomNavigationBarItem(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(7),
                  ),
                    child: Icon(Icons.add, size: 30, color: Colors.white)),
                label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined, size: 30, color: Colors.grey.shade400),
                label: "Home",
                activeIcon: Icon(Icons.notifications, color: Colors.pink.shade200, size: 30,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 30, color: Colors.grey.shade400),
                label: "Home",
                activeIcon: Icon(Icons.account_circle, color: Colors.pink.shade200, size: 30,)
            ),
          ]
      ),

    );
  }
}
