// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/data/repository/country_repository.dart';
import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';
import 'package:the_baetles_chord_play/data/repository/video_repository.dart';
import 'package:the_baetles_chord_play/domain/model/video.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_performer.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_valid.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_liked_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_play_state_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_country.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';
import 'package:the_baetles_chord_play/presentation/bridge/bridge_view_model.dart';
import 'package:the_baetles_chord_play/presentation/home/home_view_model.dart';
import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/service/auth_service.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_service.dart';
import 'package:the_baetles_chord_play/service/google_auth_service.dart';

import 'domain/use_case/get_my_sheets_of_video.dart';
import 'domain/use_case/get_nickname_suggestion.dart';
import 'domain/use_case/get_user_id_token.dart';
import 'domain/use_case/update_play_state.dart';
import 'domain/use_case/sign_up.dart';
import 'utility/navigate.dart';

Future<void> main() async {
  // Represent splash page
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool hadSignedIn = FirebaseAuth.instance.currentUser != null &&
      await AuthRepository().login((await AuthRepository().fetchIdToken())!);

  await CountryCodes.init();

  FlutterNativeSplash.remove();

  // runApp(MyApp(hadSignedIn));
  runApp(MyApp(true));
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
              CheckNicknameValid(AuthRepository()),
              GetMusicToCheckPreference(
                  VideoRepository(),
                  GetUserCountry(CountryRepository()),
                  GetUserIdToken(AuthRepository())),
              SignInWithIdToken(AuthRepository(), GoogleAuthService()),
              GetNicknameSuggestion(AuthRepository()),
              SignUp(AuthRepository(), GetUserIdToken(AuthRepository()),
                  GetUserCountry(CountryRepository()))),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(
              GetVideoCollection(VideoRepository(), AuthRepository()),
              GetRecommendedVideo(VideoRepository(), AuthRepository())),
        ),
        ChangeNotifierProvider(
          create: (_) => BridgeViewModel(
              GetUserIdToken(AuthRepository()),
              GetSheetsOfVideo(SheetRepository()),
              GetMySheetsOfVideo(
                  GetSheetsOfVideo(SheetRepository()), AuthRepository()),
              GetLikedSheetsOfVideo(
                  GetSheetsOfVideo(SheetRepository()), SheetRepository())),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            ConductorService conductor = ConductorService();
            return PerformanceViewModel(UpdatePlayState(conductor), AddPerformer(conductor), AddPlayStateListener(conductor));
          },
        ),
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
