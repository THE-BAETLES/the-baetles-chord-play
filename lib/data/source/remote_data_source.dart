import 'dart:collection';
import 'dart:convert';

import "package:http/http.dart" as http;

import '../../domain/model/video.dart';

class RemoteDataSource {
  // singleton instance
  static final RemoteDataSource _instance = RemoteDataSource._internal();

  static const apiServerHost = "52.78.232.241";
  static const portNumber = "8080";
  static const httpUriHead = "http://${apiServerHost}:${portNumber}";

  static const idTokenKey = "Authorization";

  static const bearer = "Bearer";

  static const ok = 200;
  static const created = 201;
  static const badRequest = 400;
  static const authorizationFail = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const conflict = 409;

  factory RemoteDataSource() {
    // singleton instance getter
    return _instance;
  }

  RemoteDataSource._internal();

  Future<bool> login(String idToken) async {
    http.Response response = await http.post(
      Uri.parse('$httpUriHead/user/login'),
      headers: {
        idTokenKey: '${bearer} ${idToken}',
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    print(response.body);

    return response.statusCode == ok;
  }

  Future<bool> signUp({
    required String idToken,
    required String country,
    required String performerGrade,
    required List<Map<String, dynamic>> earlyFavoriteSongs,
    required String nickname,
    required String gender,
  }) async {
    http.Response response = await http.post(
      Uri.parse('$httpUriHead/user/join'),
      headers: {
        idTokenKey: '${bearer} ${idToken}',
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        "country": country,
        "performer_grade": performerGrade,
        "earlyFavoriteSongs": earlyFavoriteSongs,
        "nickname": nickname,
        "gender": gender
      }),
    );

    return response.statusCode == ok;
  }

  Future<String> getNicknameSuggestion(String idToken) async {
    http.Response response = await http.get(
      Uri.parse('$httpUriHead/user/nickname'),
      headers: {idTokenKey: '${bearer} ${idToken}'},
    );

    print(response.body);

    return jsonDecode(response.body)['nickname'];
  }

  Future<bool> checkNicknameValid(String idToken, String nickname) async {
    http.Response response = await http.post(
      Uri.parse('$httpUriHead/user/check-duplication'),
      headers: {
        idTokenKey: '${bearer} ${idToken}',
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({'nickname': '${nickname}'}),
    );

    return response.statusCode == ok;
  }

  Future<UnmodifiableListView<Video>?> getVideoToCheckPreference(
    String idToken,
    String country,
    String performerGrade,
    String gender,
  ) async {
    http.Response response = await http.get(
        Uri.parse(
            '$httpUriHead/user/favorites?country=$country&performer_grade=$performerGrade&gender=$gender'),
        headers: {
          idTokenKey: '${bearer} ${idToken}',
        });

    print(response.body);

    if (response.statusCode != ok) {
      assert(false);
      return null;
    }

    List<dynamic> jsonObjects = jsonDecode(response.body)['favorites'];

    List<Video> videos =
        jsonObjects.map((jsonObject) => Video.fromJson(jsonObject)).toList();

    return UnmodifiableListView(videos);
  }
}
