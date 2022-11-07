import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'auth_service.dart';

class AppleAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  @override
  Future<String?>? getIdToken() async {
    return await _auth.currentUser?.getIdToken();
  }

  @override
  Future<UserCredential> signIn() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);

    final AuthCredential oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(oauthCredential);

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
