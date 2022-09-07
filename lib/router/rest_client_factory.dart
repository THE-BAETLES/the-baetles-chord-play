import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/recommendation/recommendation_client.dart';
import 'package:the_baetles_chord_play/router/search/search_client.dart';
import 'package:the_baetles_chord_play/router/sheet/sheet_client.dart';
import 'package:the_baetles_chord_play/router/video/video_client.dart';


class RestClientFactory {
  static final RestClientFactory _client_factory =
      RestClientFactory._internal();
  final dio = Dio();
  // TODO: Set LoadBalancer URl
  final baseUrl = dotenv.env['API_BASE_URL']!;
  String? _idToken;

  factory RestClientFactory() {
    return _client_factory;
  }

  RestClientFactory._internal() {
    (() async {
      String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (idToken != null) {
        _idToken = idToken;
        dio.options.headers['Authorization'] = "Bearer $idToken";
      }
    })();

    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user != null) {
        _idToken = await user.getIdToken();
        dio.options.headers['Authorization'] = "Bearer $_idToken";
      }
    });
  }

  RestClient? getClient(RestClientType clientType) {
    if (_idToken == null) {
      log("getClient method invoked when RestClientFactory._idToken is null");
      return null;
    }

    switch (clientType) {
      case RestClientType.recommendation:
        return RecommendationClient(dio, baseUrl: baseUrl);
        break;
      case RestClientType.search:
        return SearchClient(dio, baseUrl: baseUrl);
        break;
      case RestClientType.sheet:
        return SheetClient(dio, baseUrl: baseUrl);
        break;
      case RestClientType.video:
        return VideoClient(dio, baseUrl: baseUrl);
        break;
    }
  }
}
