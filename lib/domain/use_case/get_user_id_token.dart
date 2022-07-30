import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

class GetUserIdToken {
  final AuthRepository authRepository;

  GetUserIdToken(this.authRepository);

  Future<String?> call() async {
    return await authRepository.fetchIdToken();
  }
}