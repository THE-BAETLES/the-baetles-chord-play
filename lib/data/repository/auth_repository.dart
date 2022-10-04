import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_baetles_chord_play/data/source/remote_data_source.dart';
import 'package:the_baetles_chord_play/domain/model/performer_grade.dart';

import '../../domain/model/gender.dart';
import '../../domain/model/video.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  late final RemoteDataSource _remoteDataSource;

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    _remoteDataSource = RemoteDataSource();
  }

  Future<bool> login(String idToken) async {
    return (await _remoteDataSource.login(idToken));
  }

  Future<bool> signUp({
    required String idToken,
    required String country,
    required PerformerGrade performerGrade,
    required List<String> earlyFavoriteSongs,
    required String nickname,
    required Gender gender,
}) async {
    return (await _remoteDataSource.signUp(
      idToken: idToken,
      country: country.toUpperCase(),
      performerGrade: performerGrade.name.toUpperCase(),
      earlyFavoriteSongs: earlyFavoriteSongs,
      nickname: nickname,
      gender: gender.name.toUpperCase(),
    ));
  }

  Future<String?>? fetchIdToken({bool forceRefresh = false}) async {
    return await FirebaseAuth.instance.currentUser?.getIdToken(forceRefresh);
  }

  String? fetchUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<bool> isNicknameValid(String nickname) async {
    bool isValid =  await _remoteDataSource.checkNicknameValid((await fetchIdToken())!, nickname);
    return isValid;
  }

  Future<String?> getNicknameSuggestion() async {
    return await _remoteDataSource
        .getNicknameSuggestion((await fetchIdToken())!);
  }

  String? getUserNickname() {
    return FirebaseAuth.instance.currentUser?.displayName;
  }
}
