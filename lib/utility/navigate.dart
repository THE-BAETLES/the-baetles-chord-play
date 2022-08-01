import 'package:flutter/material.dart';

import '../presentation/bridge/bridge_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/performance/performance_page.dart';
import '../presentation/sign_in/sign_in_page.dart';
import '../presentation/sign_up/sign_up_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in-page' : (context) => SignInPage(),
    '/sign-up-page' : (context) => SignUpPage(),
    'home-page' : (context) => HomePage(),
    '/bridge-page' : (context) => BridgePage(),
    '/performance-page' : (context) => PerformancePage(),
  };
}