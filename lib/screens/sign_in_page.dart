import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../providers/auth_provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = AuthProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                try {
                  authProvider.signWithGoogle();
                  Navigator.pushNamedAndRemoveUntil(context, '/home-screen', (route) => false);
                } catch(e) {
                  if (kDebugMode && (e is FirebaseAuthException)) {
                    print(e.message!);
                  }
                }
              },
              child: const Text(
                "구글 로그인"
              ),
          ),
        ],
      ),
    );
  }
}