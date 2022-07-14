import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widgets/pages/bridge_page.dart';
import 'package:the_baetles_chord_play/widgets/pages/home_page.dart';
import 'package:the_baetles_chord_play/widgets/pages/sign_in_page.dart';

import '../widgets/pages/sign_up_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in-page' : (context) => SignInPage(),
    '/sign-up-page' : (context) => SignUpPage(),
    'home-page' : (context) => HomePage(),
    '/bridge-page' : (context) => BridgePage(),
  };
}