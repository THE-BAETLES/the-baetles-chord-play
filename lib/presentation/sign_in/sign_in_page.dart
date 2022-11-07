import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controller/sign_in_controller.dart';
import 'package:the_baetles_chord_play/domain/model/sign_in_platform.dart';
import 'package:the_baetles_chord_play/service/apple_auth_service.dart';
import 'package:the_baetles_chord_play/widget/molecule/apple_login_button.dart';
import 'package:the_baetles_chord_play/widget/molecule/google_login_button.dart';

import '../../widget/atom/app_logo.dart';
import '../../widget/molecule/guitarist_pod_image.dart';

import 'dart:io' show Platform;

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            top: 110,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: const AppLogo(),
                )
              ],
            ),
          ),

          // 로그인 버튼
          Positioned(
            top: 265,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  height: 48,
                  width: MediaQuery.of(context).size.width - 80,
                  child: GoogleLoginButton(),
                ),
                Builder(
                  builder: (context) {
                    if (Platform.isIOS) {
                      return Container(
                        margin:
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                        height: 48,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 80,
                        child: AppleLoginButton(
                          onClick: () {
                            SignInController signInController = SignInController(
                                context);
                            signInController.signIn(SignInPlatform.APPLE);
                          },
                        ),
                      );
                    } else {
                      return Container(height: 0,);
                    }
                  }
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const GuitaristPodImage(),
            ),
          ),
        ],
      ),
    );
  }
}
