import 'package:flutter/material.dart';

class ChartNavPage extends StatelessWidget {
  const ChartNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
          child: Icon(
              Icons.bar_chart, size: 100, color: Colors.white)),
    );
  }
}