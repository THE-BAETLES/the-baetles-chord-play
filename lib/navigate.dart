import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/screens/bridge_screen.dart';
import 'package:the_baetles_chord_play/screens/home_screen.dart';
import 'package:the_baetles_chord_play/screens/sign_in_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/' : (context) => SignInScreen(),
    '/home-screen' : (context) => HomeScreen(),
    '/bridge-screen' : (context) => BridgeScreen(),
  };
}