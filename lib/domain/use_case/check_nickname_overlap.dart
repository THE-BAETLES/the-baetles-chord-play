import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

class CheckNicknameOverlap {
  final AuthRepository authRepository;

  CheckNicknameOverlap(this.authRepository);

  Future<bool> call(String nickname) async {
    return await authRepository.isNicknameRegistered(nickname);
  }
}
