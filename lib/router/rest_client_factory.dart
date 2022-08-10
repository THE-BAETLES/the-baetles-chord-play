import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/recommendation/recommendation_client.dart';
import 'package:the_baetles_chord_play/router/search/search_client.dart';
import 'package:the_baetles_chord_play/router/sheet/sheet_client.dart';
import 'package:the_baetles_chord_play/router/video/video_client.dart';
import 'package:the_baetles_chord_play/router/watch_history/watch_history_client.dart';
class RestClientFactory {
  static final RestClientFactory _client_factory = new RestClientFactory._internal();
  final dio = Dio();
  // TODO: Set LoadBalancer URl

  final baseUrl = "https://";
  late String idToken;

  factory RestClientFactory() {
    return _client_factory;
  }

  RestClientFactory._internal() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if(user != null) {
        idToken = await user.getIdToken();
        dio.options.headers['Authorization'] = idToken;
      }
    });
  }

  RestClient? getClient(RestClientType clientType){
    switch(clientType) {
      case RestClientType.recommendation:
        return RecommendationClient(dio, baseUrl: baseUrl);
        break;
      case RestClientType.search:
        // TODO: Handle this case.
      return SearchClient(dio, baseUrl:  baseUrl);
        break;
      case RestClientType.sheet:
        // TODO: Handle this case.
      return SheetClient(dio, baseUrl: baseUrl);
        break;
      case RestClientType.video:
        return VideoClient(dio, baseUrl: baseUrl);
        // TODO: Handle this case.
        break;
      case RestClientType.watchHistory:
        return WatchHistoryClient(dio, baseUrl: baseUrl);
        // TODO: Handle this case.
        break;
    }
  }
}