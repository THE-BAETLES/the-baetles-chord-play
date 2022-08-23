// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:developer';

import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/data/repository/country_repository.dart';
import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';
import 'package:the_baetles_chord_play/data/repository/video_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_performer.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_valid.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_liked_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_shared_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheet_data.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_country.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_nickname.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_watch_history.dart';
import 'package:the_baetles_chord_play/domain/use_case/remove_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/set_youtube_player_controller.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';
import 'package:the_baetles_chord_play/presentation/bridge/bridge_view_model.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:the_baetles_chord_play/presentation/home/home_view_model.dart';
import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/presentation/search/search_view_model.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';
import 'package:the_baetles_chord_play/service/conductor/youtube_conductor_service.dart';
import 'package:the_baetles_chord_play/service/google_auth_service.dart';

import 'domain/model/loop.dart';
import 'domain/model/play_state.dart';
import 'domain/use_case/create_sheet.dart';
import 'domain/use_case/generate_video.dart';
import 'domain/use_case/get_my_sheets_of_video.dart';
import 'domain/use_case/get_nickname_suggestion.dart';
import 'domain/use_case/get_user_id_token.dart';
import 'domain/use_case/search_video.dart';
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

  await dotenv.load(fileName: '.env');

  // RestClientFactory initialize
  RestClientFactory();

  bool hadSignedIn = FirebaseAuth.instance.currentUser != null &&
      await AuthRepository().login((await AuthRepository().fetchIdToken())!);

  if (kDebugMode) {
    if (hadSignedIn) {
      print("sign up success");
    }
  }

  await CountryCodes.init();

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
            GetRecommendedVideo(VideoRepository(), AuthRepository()),
            GetWatchHistory(VideoRepository()),
            GetUserNickname(AuthRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BridgeViewModel(
            GetMySheetsOfVideo(
              GetSheetsOfVideo(SheetRepository()),
            ),
            GetLikedSheetsOfVideo(
              GetSheetsOfVideo(SheetRepository()),
            ),
            GetSharedSheetsOfVideo(
              GetSheetsOfVideo(SheetRepository()),
            ),
            GenerateVideo(VideoRepository()),
            CreateSheet(SheetRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingViewModel(
            GetSheetData(SheetRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) {
            YoutubeConductorService conductor = YoutubeConductorService(
                initialPlayState: PlayState(
              isPlaying: false,
              currentPosition: 0,
              tempo: 1.0,
              defaultBpm: 60,
              loop: Loop(0, -1),
              capo: 0,
            ));
            return PerformanceViewModel(
              UpdatePlayState(conductor),
              AddPerformer(conductor),
              AddConductorPositionListener(conductor),
              RemoveConductorPositionListener(conductor),
              SetYoutubePlayerController(conductor),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return SearchViewModel(SearchVideo(VideoRepository()));
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return SheetCreationDialogViewModel();
          },
        )
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

//
// =======
// MyApp({super.key});
//
// @override
// Widget build(BuildContext context) {
//
//   return MaterialApp(
//       title: 'Startup Name Generator',
//       home: Scaffold(
//       appBar: AppBar(
//       title: const Text("Chord Play"),
//   backgroundColor: Color.fromARGB(255, 28, 28, 30),
//   ),
//   body: Column(
//   children: [
//   VideoThumbnail(),
//   ChordDetectionTest(),
//   ]
//   >>>>>>> pitch-tracking
//
//
// class ChordDetectionTest extends StatefulWidget {
//   const ChordDetectionTest({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _ChordDetectionTestState();
// }
//
// class _ChordDetectionTestState extends State<ChordDetectionTest> {
//   static const platform = MethodChannel('com.example.baetles/chord-detection');
//
//   String _lastPlayedChord = "Unknown chord.";
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: [ElevatedButton(
//             onPressed: _startDetectingChord,
//             child: Text("음 판별 시작")
//         ),
//         Text(_lastPlayedChord),
//       ]
//     );
//   }
//
//   Future<void> _startDetectingChord() async {
//     String chord;
//
//     try {
//       final int result = await platform.invokeMethod('startDetectingChord');
//       chord = 'Played chord is $result';
//     } on PlatformException catch (e) {
//       chord = "Failed to get played chord: '${e.message}'.";
//     }
//
//     setState(() {
//       // 결과 저장
//       _lastPlayedChord = chord;
//     });
//   }
// }
