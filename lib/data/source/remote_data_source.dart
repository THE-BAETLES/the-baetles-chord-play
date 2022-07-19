import 'package:the_baetles_chord_play/domain/model/user.dart';

class RemoteDataSource {
  Future<User?> fetchUserInfo(String userId, String accessToken) async {
    // dummy data
    //return User('userId', '현준', SignInPlatform.GOOGLE, "Korea", Language.korean, Gender.male, Membership.premium);
    return null;
  }

  Future<bool> setUserCredential(String userId, String accessToken) async {
    // test code
    print('전송!');
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}