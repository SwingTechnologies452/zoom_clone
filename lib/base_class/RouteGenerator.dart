/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_template/pages/PaymentPage.dart';

// return PageTransition(
//   child: SplashPage(),
//   type: PageTransitionType.fade,
// );

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/mainPage':
        return MaterialPageRoute(builder: (_) => MainPage());
    }
  }
}
