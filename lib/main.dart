// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/data/repository/country_repository.dart';
import 'package:the_baetles_chord_play/data/repository/video_repository.dart';
import 'package:the_baetles_chord_play/domain/model/video.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_overlap.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_country.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';
import 'package:the_baetles_chord_play/presentation/home/home_view_model.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/service/auth_service.dart';
import 'package:the_baetles_chord_play/service/google_auth_service.dart';

import 'utility/navigate.dart';

Future<void> main() async {
  // Represent splash page
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool hadSignedIn = await AuthRepository().hadSignedIn();

  FlutterNativeSplash.remove();

  runApp(MyApp(hadSignedIn));
}

class MyApp extends StatelessWidget {
  late final String _initialRoute;

  MyApp(bool hadSignedIn) {
    // 이전에 로그인을 했던 기록이 남아있다면 홈 페이지로 바로 넘어감.
    // TODO : 이전 id token refresh 및 signWithIdToken
    _initialRoute = hadSignedIn ? 'home-page' : 'sign-in-page';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SignUpViewModel(
                  CheckNicknameOverlap(AuthRepository()),
                  GetMusicToCheckPreference(
                      VideoRepository(), GetUserCountry(CountryRepository())),
                  SignInWithIdToken(AuthRepository(), GoogleAuthService())
                )),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(
                GetVideoCollection(VideoRepository(), AuthRepository()),
                GetRecommendedVideo(VideoRepository(), AuthRepository()))),
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
