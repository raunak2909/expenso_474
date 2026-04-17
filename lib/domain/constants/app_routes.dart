

import 'package:flutter/material.dart';

import '../../ui/pages/dashboard/dashboard_page.dart';
import '../../ui/pages/on_boarding/login/login_page.dart';
import '../../ui/pages/on_boarding/sign_up/sign_up_page.dart';
import '../../ui/pages/splash/splash_page.dart';

class AppRoutes{

  static const String SPLASH_ROUTE = '/';
  static const String LOGIN_ROUTE = '/login';
  static const String SIGN_UP_ROUTE = '/sign_up';
  static const String DASHBOARD_ROUTE = '/dashboard';


  static Map<String, WidgetBuilder> mRoutes = {
    SPLASH_ROUTE: (context) => SplashPage(),
    LOGIN_ROUTE: (context) => LoginPage(),
    SIGN_UP_ROUTE: (context) => SignUpPage(),
    DASHBOARD_ROUTE: (context) => DashboardPage(),
  };


}