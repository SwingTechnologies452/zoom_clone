/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

import 'package:flutter/material.dart';
import 'package:zoom_clone/networking/jitsi/JitsiVideoPage.dart';
import 'package:zoom_clone/pages/LoginPage.dart';
import 'package:zoom_clone/pages/MainPage.dart';
import 'package:zoom_clone/pages/SplashPage.dart';

// return PageTransition(
//   child: SplashPage(),
//   type: PageTransitionType.fade,
// );

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/loginPage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/mainPage':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/jitsi':
        return MaterialPageRoute(builder: (_) => JitsiVideoPage());
      case '/splashPage':
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
    return null;
  }
}
