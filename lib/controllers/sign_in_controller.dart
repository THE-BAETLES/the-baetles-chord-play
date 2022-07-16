import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/datas/repositories/auth_repository.dart';
import 'package:the_baetles_chord_play/services/auth_service.dart';
import 'package:the_baetles_chord_play/services/google_auth_service.dart';
import 'package:the_baetles_chord_play/utilities/navigate.dart';

import '../datas/models/sign_in_platform.dart';

class SignInController {
  BuildContext context;

  SignInController(this.context);

  void signIn(SignInPlatform platform) async {
    AuthService authService;

    switch (platform) {
      case SignInPlatform.GOOGLE:
        authService = GoogleAuthService();
        break;
    }

    String userId;
    String accessToken;

    try {
      await authService.signIn();

      userId = (await authService.getUserId())!;
      accessToken = (await authService.getAccessToken())!;
    } catch (e) {
      rethrow;
      if (kDebugMode) {
        log("SignInController: 로그인이 정상적으로 처리되지 않음");
      }

      // Todo : 나중에 애널리틱스 추가하기
      return;
    }

    AuthRepository authRepository = AuthRepository();

    if (!(await authRepository.hadSignedUp(userId, accessToken))) {
      Navigator.pushNamedAndRemoveUntil(context, '/sign-up-page', (route) => false);
      print("to sign up page!");
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, 'home-page', (route) => false);
    print("to home page!");
  }
}
