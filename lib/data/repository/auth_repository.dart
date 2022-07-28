import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_baetles_chord_play/data/source/local_data_source.dart';
import 'package:the_baetles_chord_play/data/source/remote_data_source.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  late final RemoteDataSource _remoteDataSource;

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    _remoteDataSource = RemoteDataSource();
  }

  Future<bool> hadSignedUp(String idToken) async {
    return (await _remoteDataSource.fetchUserInfo(idToken)) != null;
  }

  Future<String?>? fetchIdToken({bool forceRefresh = false}) async {
    return await FirebaseAuth.instance.currentUser?.getIdToken(forceRefresh);
  }

  String? fetchUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<bool> isNicknameRegistered(String nickname) async {
    // TODO : 닉네임이 등록되어 있는지 조회
    return Future(() => false); // dummy data
  }
}
