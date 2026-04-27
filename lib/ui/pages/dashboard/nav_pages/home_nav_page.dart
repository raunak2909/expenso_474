import 'package:flutter/material.dart';

class HomeNavPage extends StatelessWidget {
  const HomeNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
          child: Icon(
              Icons.home, size: 100, color: Colors.white)),
    );
  }
}
