import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_baetles_chord_play/service/orientation_manager/screen_orientation.dart';

import '../../utility/navigate.dart';

class OrientationManager extends NavigatorObserver {
  final HashSet<String> _portraitOnlyPage = HashSet.of({
    'sign-in-page',
    '/sign-up-page',
    'main-page',
    '/bridge-page',
    '/search-page',
    '/delete-account-page',
  });

  final HashSet<String> _landscapeOnlyPage = HashSet.of({
    '/performance-page',
    '/loading-page',
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_portraitOnlyPage.contains(route.settings.name)) {
      _setOrientation(ScreenOrientation.portraitOnly);
    } else if (_landscapeOnlyPage.contains(route.settings.name)) {
      _setOrientation(ScreenOrientation.landscapeOnly);
    } else {
      assert(false);  // todo: exception throw
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) {
      return;
    }

    if (_portraitOnlyPage.contains(previousRoute.settings.name)) {
      _setOrientation(ScreenOrientation.portraitOnly);
    } else if (_landscapeOnlyPage.contains(previousRoute.settings.name)) {
      _setOrientation(ScreenOrientation.landscapeOnly);
    } else {
      assert(false);  // todo: exception throw
    }
  }

  void _setOrientation(ScreenOrientation orientation) {
    List<DeviceOrientation> preferredOrientations;

    switch (orientation) {
      case ScreenOrientation.portraitOnly:
        preferredOrientations = [
          DeviceOrientation.portraitUp,
        ];
        break;
      case ScreenOrientation.landscapeOnly:
        preferredOrientations = [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
        break;
      case ScreenOrientation.rotating:
        preferredOrientations = [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
        break;
      default:
        assert(false);
        preferredOrientations = [DeviceOrientation.portraitUp];
    }

    SystemChrome.setPreferredOrientations(preferredOrientations);
  }
}