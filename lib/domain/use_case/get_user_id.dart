import 'package:the_baetles_chord_play/data/repository/user_repository.dart';

class GetUserId {
  final UserRepository _userRepository;

  GetUserId(this._userRepository);

  Future<String?> call() async {
    return await _userRepository.getUserId();
  }
}