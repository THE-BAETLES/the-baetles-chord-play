import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/google_login_button.dart';

import '../../widget/atom/app_logo.dart';
import '../../widget/molecule/guitarist_pod_image.dart';

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
              children: const [
                AppLogo(),
              ],
            ),
          ),

          // 로그인 버튼
          Positioned(
            top: 265,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              height: 48,
              width: MediaQuery.of(context).size.width - 80,
              child: GoogleLoginButton(),
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
