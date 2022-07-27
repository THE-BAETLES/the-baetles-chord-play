import 'package:the_baetles_chord_play/data/source/local_data_source.dart';
import 'package:the_baetles_chord_play/data/source/remote_data_source.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  late final LocalDataSource _localDataSource;
  late final RemoteDataSource _remoteDataSource;

  // shared preference key
  static const userIdKey = "userId";
  static const idTokenKey = "idToken";

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    _localDataSource = LocalDataSource();
    _remoteDataSource = RemoteDataSource();
  }

  Future<bool> hadSignedUp(String userId, String accessToken) async {
    return (await _remoteDataSource.fetchUserInfo(userId, accessToken)) != null;
  }

  Future<bool> hadSignedIn() async {
    await _localDataSource.isInitialized; // local data source가 준비 완료될 때까지 대기
    return (await _localDataSource.fetchSharedPreference(idTokenKey)) != null;
  }

  Future<bool> storeUserCredential(String userId, String idToken) async {
    _localDataSource.storeSharedPreference(userIdKey, userId);
    _localDataSource.storeSharedPreference(idTokenKey, idToken);

    bool isSuccessful = await _remoteDataSource.setUserCredential(userId, idToken);
    return isSuccessful;
  }

  Future<String?> fetchIdToken() async {
    return await _localDataSource.fetchSharedPreference(idTokenKey) as String?;
  }

  Future<String?> fetchUserId() async {
    return await _localDataSource.fetchSharedPreference(userIdKey) as String?;
  }

  Future<bool> isNicknameRegistered(String nickname) async {
    // TODO : 닉네임이 등록되어 있는지 조회
    return Future(() => false); // dummy data
  }
}
