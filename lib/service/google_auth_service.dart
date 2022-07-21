import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_baetles_chord_play/service/auth_service.dart';

class GoogleAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  @override
  Future<String?>? getAccessToken() async {
    return await _auth.currentUser?.getIdToken();
  }

  @override
  Future<UserCredential> signIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await _auth.signInWithCredential(credential);

    // 백엔드 협업용 id 토큰 받아오는 코드
    if (kDebugMode) {
      print("${await userCredential.user?.getIdToken()}");
      print("id token: ${await userCredential.user?.getIdTokenResult()}");
      String idToken = (await userCredential.user?.getIdToken())!;

      for (int i = 0; i <= idToken.length; i += 300) {
        print(idToken.substring(i, min(i + 300, idToken.length)));
      }
    }

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

}