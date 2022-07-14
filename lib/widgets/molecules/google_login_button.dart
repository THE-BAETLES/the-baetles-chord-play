import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controllers/sign_in_controller.dart';
import 'package:the_baetles_chord_play/datas/models/sign_in_platform.dart';

import '../atoms/google_icon.dart';

class GoogleLoginButton extends StatelessWidget {
  GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 243, 243, 243),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          try {
            SignInController signInController = SignInController(context);
            signInController.signIn(SignInPlatform.GOOGLE);
          } catch (e) {
            if (kDebugMode && (e is FirebaseAuthException)) {
              print(e.message!);
            }
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            GoogleIcon(),
            const Center(
              child: Text(
                "구글 계정으로 로그인",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 14,
                  color: Color.fromARGB(255, 4, 4, 4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
