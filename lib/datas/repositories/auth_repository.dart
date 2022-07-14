import 'package:the_baetles_chord_play/datas/sources/local_data_source.dart';
import 'package:the_baetles_chord_play/datas/models/user.dart';
import 'package:the_baetles_chord_play/datas/sources/remote_data_source.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  late final LocalDataSource _localDataSource;
  late final RemoteDataSource _remoteDataSource;

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
    return (await _localDataSource.fetchUser()) != null;
  }

  Future<bool> storeUserCredential(String userId, String accessToken) async {
    _localDataSource.storeSharedPreference("userId", userId);
    _localDataSource.storeSharedPreference("accessToken", accessToken);

    bool isSuccessful = await _remoteDataSource.setUserCredential(userId, accessToken);

    return isSuccessful;
  }
}
