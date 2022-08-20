import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

class GetUserNickname {
  AuthRepository _authRepository;

  GetUserNickname(this._authRepository);

  String? call() {
    return _authRepository.getUserNickname();
  }
}