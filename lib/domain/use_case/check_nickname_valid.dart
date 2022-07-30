import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

class CheckNicknameValid {
  final AuthRepository authRepository;

  CheckNicknameValid(this.authRepository);

  Future<bool> call(String nickname) async {
    return await authRepository.isNicknameValid(nickname);
  }
}
