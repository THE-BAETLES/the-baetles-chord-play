import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/delete_account/delete_account_page.dart';
import 'package:the_baetles_chord_play/presentation/main/main_page.dart';

import '../presentation/bridge/bridge_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/loading/loading_page.dart';
import '../presentation/performance/performance_page.dart';
import '../presentation/search/search_page.dart';
import '../presentation/sign_in/sign_in_page.dart';
import '../presentation/sign_up/sign_up_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in-page' : (context) => SignInPage(),
    '/sign-up-page' : (context) => SignUpPage(),
    'main-page' : (context) => MainPage(),
    // 'home-page' : (context) => HomePage(),
    '/bridge-page' : (context) => BridgePage(),
    '/performance-page' : (context) => PerformancePage(key: UniqueKey()),
    '/loading-page' : (context) => LoadingPage(key: UniqueKey()),
    '/search-page' : (context) => SearchPage(),
    '/delete-account-page' : (context) => const DeleteAccountPage(),
  };
}