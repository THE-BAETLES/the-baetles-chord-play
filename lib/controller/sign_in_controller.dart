import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/service/auth_service.dart';
import 'package:the_baetles_chord_play/service/google_auth_service.dart';

import '../domain/model/sign_in_platform.dart';

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

    String idToken;

    try {
      UserCredential credential = await authService.signIn();

      idToken = (await credential.user!.getIdToken());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        log("SignInController: 로그인이 정상적으로 처리되지 않음. ${e.message}");
      }

      // Todo : 나중에 애널리틱스 추가하기
      return;
    }

    AuthRepository authRepository = AuthRepository();

    if (await authRepository.login(idToken)) {
      Navigator.pushNamedAndRemoveUntil(context, 'home-page', (route) => false);
      print("to home page!");
    } else {
      Navigator.pushNamed(context, '/sign-up-page');
      print("to sign up page!");
    }
  }
}
