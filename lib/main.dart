import 'dart:developer';

import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/data/repository/country_repository.dart';
import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';
import 'package:the_baetles_chord_play/data/repository/video_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_performer.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_valid.dart';
import 'package:the_baetles_chord_play/domain/use_case/delete_sheet.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_liked_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_shared_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheet_data.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_country.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_nickname.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_watch_history.dart';
import 'package:the_baetles_chord_play/domain/use_case/patch_sheet_data.dart';
import 'package:the_baetles_chord_play/domain/use_case/remove_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/set_youtube_player_controller.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';
import 'package:the_baetles_chord_play/presentation/bridge/bridge_view_model.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:the_baetles_chord_play/presentation/collection/collection_view_model.dart';
import 'package:the_baetles_chord_play/presentation/home/home_view_model.dart';
import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/presentation/search/search_view_model.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';
import 'package:the_baetles_chord_play/service/conductor/youtube_conductor_service.dart';
import 'package:the_baetles_chord_play/service/google_auth_service.dart';
import 'package:the_baetles_chord_play/service/orientation_manager/orientation_manager.dart';
import 'package:the_baetles_chord_play/service/orientation_manager/screen_orientation.dart';
import 'package:the_baetles_chord_play/service/progress_service.dart';
import 'package:the_baetles_chord_play/widget/molecule/chord_picker.dart';

import 'controller/chord_picker_view_model.dart';
import 'data/repository/user_repository.dart';
import 'domain/model/loop.dart';
import 'domain/model/play_option.dart';
import 'domain/use_case/create_sheet_duplication.dart';
import 'domain/use_case/generate_video.dart';
import 'domain/use_case/get_my_collection.dart';
import 'domain/use_case/get_my_sheets_of_video.dart';
import 'domain/use_case/get_nickname_suggestion.dart';
import 'domain/use_case/get_user_id_token.dart';
import 'domain/use_case/move_play_position.dart';
import 'domain/use_case/search_video.dart';
import 'domain/use_case/update_play_option.dart';
import 'domain/use_case/sign_up.dart';
import 'utility/navigate.dart';

Future<void> main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await dotenv.load(fileName: '.env');

  RestClientFactory(); // Initialize restClientFactory

  ProgressService(); // Initialize progressService

  await CountryCodes.init(); // Initialize country code module

  bool hadSignedIn = FirebaseAuth.instance.currentUser != null &&
      await AuthRepository().login((await AuthRepository().fetchIdToken())!);

  if (hadSignedIn) {
    // 백엔드 협업용 id 토큰 받아오는 코드
    if (kDebugMode) {
      log("${await AuthRepository().fetchIdToken()}");
    }
  }

  runApp(MyApp(hadSignedIn));
}

class MyApp extends StatelessWidget {
  final _orientationManager = OrientationManager();
  late final String _initialRoute;

  MyApp(bool hadSignedIn) {
    // 이전에 로그인을 했던 기록이 남아있다면 홈 페이지로 바로 넘어감.
    // TODO : 이전 id token refresh 및 signWithIdToken
    _initialRoute = hadSignedIn ? 'main-page' : 'sign-in-page';
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
            CreateSheetDuplication(SheetRepository()),
            DeleteSheet(SheetRepository()),
            GetSheetData(SheetRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            YoutubeConductorService conductor = YoutubeConductorService(
                initialPlayOption: PlayOption(
              isPlaying: false,
              tempo: 1.0,
              defaultBpm: 60,
              loop: Loop.infinite(),
              capo: 0,
            ));
            return PerformanceViewModel(
              UpdatePlayOption(conductor),
              SetPlayPosition(conductor),
              AddPerformer(conductor),
              AddConductorPositionListener(conductor),
              RemoveConductorPositionListener(conductor),
              SetYoutubePlayerController(conductor),
              PatchSheetData(SheetRepository()),
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
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CollectionViewModel(
              CollectionRepository(),
              GetMyCollection(CollectionRepository()),
            );
          },
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: _initialRoute,
          routes: Navigate.routes,
          navigatorObservers: [_orientationManager],
        );
      },
    );
  }
}
