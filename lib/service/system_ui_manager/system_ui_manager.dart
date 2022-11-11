import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiManager extends NavigatorObserver {
  final Map<String, SystemUiMode> systemUiTable = {
    'sign-in-page' : SystemUiMode.manual,
    '/sign-up-page' : SystemUiMode.manual,
    'main-page' : SystemUiMode.manual,
    '/bridge-page' : SystemUiMode.manual,
    '/search-page' : SystemUiMode.manual,
    '/performance-page' : SystemUiMode.immersiveSticky,
    '/loading-page' : SystemUiMode.immersiveSticky,
    '/delete-account-page' : SystemUiMode.manual,
  };


  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) {
      return;
    }

    String name = route.settings.name!;
    _setSystemUiMode(systemUiTable[name]!);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) {
      return;
    }

    String name = previousRoute.settings.name!;
    _setSystemUiMode(systemUiTable[name]!);
  }

  void _setSystemUiMode(SystemUiMode systemUiMode) {
    SystemChrome.setEnabledSystemUIMode(systemUiMode, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }
}