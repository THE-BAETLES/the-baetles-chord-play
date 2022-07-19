import 'package:flutter/foundation.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_overlap.dart';

class SignUpViewModel with ChangeNotifier {
  final CheckNicknameOverlap checkNicknameOverlap;

  int _pageOffset = 0;
  bool _isNextButtonVisible = false;
  bool _isNicknameValid = true;
  String _inputNickname = "";
  String _confirmedNickname = ""; // 초기 닉네임 받아와야 함

  int get pageOffset => _pageOffset;

  bool get isNextButtonVisible => _isNextButtonVisible;

  bool get isNicknameValid => _isNicknameValid;

  String get inputNickname => _inputNickname;

  String get confirmedNickname => _confirmedNickname;

  SignUpViewModel(this.checkNicknameOverlap);

  void onChangeNickname(String nickname) {
    _inputNickname = nickname;

    final validChars = RegExp(r"^[가-힣0-9a-zA-Z_]+$");
    final result = (3 <= nickname.length && validChars.hasMatch(nickname));

    _isNicknameValid = result;
    _isNextButtonVisible = result;
    notifyListeners();
  }

  Future<String?> onConfirmNickname(String nickname) async {
    _isNextButtonVisible = false;

    // 닉네임 중복 체크
    bool isOverlapped = await checkNicknameOverlap(nickname);

    if (isOverlapped) {
      return "이미 사용중인 닉네임입니다!";
    }

    _confirmedNickname = nickname;
    _pageOffset++;

    notifyListeners();
    return null;
  }
}
