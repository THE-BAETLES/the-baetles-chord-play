import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

class GetNicknameSuggestion {
  AuthRepository authRepository;

  GetNicknameSuggestion(this.authRepository);

  Future<String> call() async {
    return await authRepository.getNicknameSuggestion();
  }
}