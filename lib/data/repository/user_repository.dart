import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';
import 'package:the_baetles_chord_play/router/user/user_client.dart';

import '../../model/api/response/user/get_user_response.dart';
import '../../router/client.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  Future<String?> getUserId() async {
    UserClient client = RestClientFactory().getClient(RestClientType.user) as UserClient;
    GetUserResponse response = await client.getUser();
    return response.data?.id;
  }
}