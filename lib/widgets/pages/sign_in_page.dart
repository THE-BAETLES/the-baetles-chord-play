import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widgets/atoms/flower_pod_image.dart';
import 'package:the_baetles_chord_play/widgets/atoms/google_icon.dart';
import 'package:the_baetles_chord_play/widgets/atoms/guitarist_image.dart';
import 'package:the_baetles_chord_play/widgets/molecules/google_login_button.dart';
import '../molecules/guitarist_pod_image.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '로고자리',
                ),
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
