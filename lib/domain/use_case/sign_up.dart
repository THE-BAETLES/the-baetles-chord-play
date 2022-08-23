import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/domain/model/performer_grade.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_id_token.dart';

import '../model/gender.dart';
import '../model/video.dart';
import 'get_user_country.dart';

class SignUp {
  AuthRepository _authRepository;
  GetUserIdToken _getUserIdToken;
  GetUserCountry _getUserCountry;

  SignUp(this._authRepository, this._getUserIdToken, this._getUserCountry);

  Future<bool> call({
    required PerformerGrade performerGrade,
    required List<String> earlyFavoriteSongs,
    required String nickname,
    required Gender gender,
  }) async {
    return await _authRepository.signUp(
      idToken: (await _getUserIdToken())!,
      country: (await _getUserCountry())!,
      performerGrade: performerGrade,
      earlyFavoriteSongs: earlyFavoriteSongs,
      nickname: nickname,
      gender: gender,
    );
  }
}
