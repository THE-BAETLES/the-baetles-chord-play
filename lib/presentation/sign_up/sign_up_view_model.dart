import 'dart:collection';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_valid.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_nickname_suggestion.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';

import '../../domain/model/gender.dart';
import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/sign_up.dart';

class SignUpViewModel with ChangeNotifier {
  // use case
  final CheckNicknameValid checkNicknameValid;
  final GetMusicToCheckPreference getMusicToCheckPreference;
  final SignInWithIdToken signInWithIdToken;
  final GetNicknameSuggestion getNicknameSuggestion;
  final SignUp signUp;

  static const _nicknamePage = 0;
  static const _genderPage = 1;
  static const _gradePage = 2;
  static const _preferencePage = 3;
  static const _completePageOffset = 4;

  static const _minSelectionCount = 3;

  UnmodifiableListView<Video> musicToCheckPreference = UnmodifiableListView([]);

  final List<Video> _preferredSongs = [];
  int _currentPage = _nicknamePage;
  bool _isNicknameValid = true;
  String _inputNickname = "";
  String? _confirmedNickname;
  Gender? _selectedGender;
  PerformerGrade? _selectedGrade;

  int get pageOffset => _currentPage;

  bool get isNicknameValid => _isNicknameValid;

  bool get isNicknameConfirmButtonVisible => _isNicknameValid;

  String get inputNickname => _inputNickname;

  String? get confirmedNickname => _confirmedNickname;

  Gender? get selectedGender => _selectedGender;

  bool get isGenderConfirmButtonVisible => _selectedGender != null;

  PerformerGrade? get selectedGrade => _selectedGrade;

  bool get isGradeConfirmButtonVisible => _selectedGrade != null;

  bool get isPreferenceConfirmButtonVisible => _preferredSongs.length >= _minSelectionCount;

  SignUpViewModel(
    this.checkNicknameValid,
    this.getMusicToCheckPreference,
    this.signInWithIdToken,
    this.getNicknameSuggestion,
    this.signUp,
  ) {
    // TODO : 가져온 닉네임 반영되도록 수정
    // getNicknameSuggestion().then((nickname) {
    //   _inputNickname = nickname;
    //   notifyListeners();
    // });
  }

  Future<void> resetViewModel() async {
    _preferredSongs.clear();
    _currentPage = _nicknamePage;
    _isNicknameValid = false;
    _inputNickname = await getNicknameSuggestion();
    _confirmedNickname = null;
    _selectedGender = null;
    _selectedGrade = null;

    notifyListeners();
  }

  void onChangeNickname(String nickname) {
    _inputNickname = nickname;

    final validChars = RegExp(r"^[가-힣0-9a-zA-Z_]+$");
    final result = (3 <= nickname.length && validChars.hasMatch(nickname));

    _isNicknameValid = result;
    notifyListeners();
  }

  Future<String?> onConfirmNickname(String nickname) async {
    // 닉네임 중복 및 유효성 체크
    bool isValid = await checkNicknameValid(nickname);

    if (!isValid) {
      _isNicknameValid = false;
      notifyListeners();
      return "이미 사용중인 닉네임입니다!";
    }

    _confirmedNickname = inputNickname;
    _currentPage = _genderPage;
    notifyListeners();
    return null;
  }

  void onChangeGender(Gender? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void onConfirmGender() {
    assert(_selectedGender != null);

    _currentPage = _gradePage;
    notifyListeners();
    return;
  }

  void onChangeGrade(PerformerGrade? grade) {
    _selectedGrade = grade;
    notifyListeners();
  }

  void onConfirmGrade() {
    assert(_selectedGrade != null);

    Future.microtask(() async {
      musicToCheckPreference =
          (await getMusicToCheckPreference(_selectedGrade!, _selectedGender!))!;
      notifyListeners();
    });

    _currentPage = _preferencePage;
    notifyListeners();
    return;
  }

  void onChangePreferredSong(Video video, bool isPreferred) {
    if (isPreferred) {
      if (!_preferredSongs.contains(video)) {
        _preferredSongs.add(video);
      }
    } else {
      _preferredSongs.remove(video);
    }

    notifyListeners();
  }

  Future<bool> onConfirmPreferredSong() async {
    bool isSignUpSuccessful = await signUp(
      performerGrade: _selectedGrade!,
      earlyFavoriteSongs: _preferredSongs.map((e) => e.id).toList(),
      nickname: _confirmedNickname!,
      gender: _selectedGender!,
    );

    if (isSignUpSuccessful) {
      // 회원가입이 성공적일 때
      _currentPage = _completePageOffset;
    } else {
      // 성공적이지 않으면 회원가입을 처음부터 다시 진행함.
      await resetViewModel();
    }

    notifyListeners();
    return isSignUpSuccessful;
  }

  Future<bool> onCompleteButtonClicked() async {
    signInWithIdToken();

    // 로그인 성공 시 true 반환
    return true;
  }
}
