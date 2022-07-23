import 'dart:collection';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/check_nickname_overlap.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_music_to_check_preference.dart';
import 'package:the_baetles_chord_play/domain/use_case/sign_in_with_id_token.dart';

import '../../domain/model/gender.dart';
import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';

class SignUpViewModel with ChangeNotifier {
  // use case
  final CheckNicknameOverlap checkNicknameOverlap;
  final GetMusicToCheckPreference getMusicToCheckPreference;
  final SignInWithIdToken signInWithIdToken;

  static const _nicknamePageOffset = 0;
  static const _genderPageOffset = 1;
  static const _gradePageOffset = 2;
  static const _preferencePageOffset = 3;
  static const _completePageOffset = 4;

  UnmodifiableListView<Video> musicToCheckPreference = UnmodifiableListView([]);

  final List<Video> _preferredSongs = [];
  int _pageOffset = _nicknamePageOffset;
  bool _isNicknameValid = true;
  String _inputNickname = "";
  String? _confirmedNickname;
  Gender? _selectedGender;
  PerformerGrade? _selectedGrade;

  int get pageOffset => _pageOffset;

  bool get isNicknameValid => _isNicknameValid;

  bool get isNicknameConfirmButtonVisible => _isNicknameValid;

  String get inputNickname => _inputNickname;

  String? get confirmedNickname => _confirmedNickname;

  Gender? get selectedGender => _selectedGender;

  bool get isGenderConfirmButtonVisible => _selectedGender != null;

  PerformerGrade? get selectedGrade => _selectedGrade;

  bool get isGradeConfirmButtonVisible => _selectedGrade != null;

  bool get isPreferenceConfirmButtonVisible => _preferredSongs.length >= 3;

  SignUpViewModel(
    this.checkNicknameOverlap,
    this.getMusicToCheckPreference,
    this.signInWithIdToken,
  );

  void onChangeNickname(String nickname) {
    _inputNickname = nickname;

    final validChars = RegExp(r"^[가-힣0-9a-zA-Z_]+$");
    final result = (3 <= nickname.length && validChars.hasMatch(nickname));

    _isNicknameValid = result;
    notifyListeners();
  }

  Future<String?> onConfirmNickname(String nickname) async {
    // 닉네임 중복 체크
    bool isOverlapped = await checkNicknameOverlap(nickname);

    if (isOverlapped) {
      _isNicknameValid = false;
      notifyListeners();
      return "이미 사용중인 닉네임입니다!";
    }

    _confirmedNickname = inputNickname;
    _pageOffset = _genderPageOffset;
    notifyListeners();
    return null;
  }

  void onChangeGender(Gender? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void onConfirmGender() {
    assert(_selectedGender != null);

    _pageOffset = _gradePageOffset;
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
      musicToCheckPreference = await getMusicToCheckPreference(_selectedGrade!);
      notifyListeners();
    });

    _pageOffset = _preferencePageOffset;
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

  Future<void> onConfirmPreferredSong() async {
    // TODO : 서버 전송 작업

    // 전송이 성공적일 때
    _pageOffset = _completePageOffset;

    // 전송이 실패했을 때
    // TODO : sign in 페이지로 돌아가기

    // TODO : sign up view model 데이터 리셋

    notifyListeners();
  }

  Future<bool> onCompleteButtonClicked() async {
    signInWithIdToken();

    // 로그인 성공 시 true 반환
    return true;
  }
}
