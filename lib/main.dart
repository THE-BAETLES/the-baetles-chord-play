// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_overlap.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';

import 'utility/navigate.dart';

Future<void> main() async {
  // Represent splash page
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterNativeSplash.remove();
  bool hadSignedIn = await AuthRepository().hadSignedIn();

  runApp(MyApp(hadSignedIn));
}

class MyApp extends StatelessWidget {
  late final String _initialRoute;

  MyApp(bool hadSignedIn) {
    // 이전에 로그인을 했던 기록이 남아있다면 홈 페이지로 바로 넘어감.
    _initialRoute = hadSignedIn ? 'home-page' : 'sign-in-page';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                SignUpViewModel(CheckNicknameOverlap(AuthRepository()))),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: _initialRoute,
          routes: Navigate.routes,
        );
      },
    );
  }
}
