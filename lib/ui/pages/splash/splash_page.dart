import 'dart:async';

import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:expenso_474/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int uid = prefs.getInt(AppConstants.PREF_USER_KEY) ?? 0;

      String nextPage = AppRoutes.LOGIN_ROUTE;

      if(uid>0){
        nextPage = AppRoutes.DASHBOARD_ROUTE;
      }
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Card(
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child:  Image.asset("assets/images/logo.png", width: 50, height: 50,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text("Expenso", style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),)
                ],
              ),
            ),
            Positioned(
              bottom: 31,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text.rich(TextSpan(
                      text: "Powered by ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(text: "WsCube Tech", style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),)
                      ]
                    ), ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 200,
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Text("Version 1.0.0", style: TextStyle(
                      letterSpacing: 5,
                      fontSize: 10,
                      color: Colors.grey,
                    ),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
