import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';

import '../../service/auth_service.dart';

class SignInWithIdToken {
  final AuthRepository _authRepository;
  final AuthService _authService;

  SignInWithIdToken(this._authRepository, this._authService);

  Future<void> call() async {
    _authRepository.storeUserCredential(
      _authService.getUserId()!,
      (await _authService.getIdToken())!,
    );
  }
}
