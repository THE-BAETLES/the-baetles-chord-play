import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/organism/simple_app_bar.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: "계정 삭제",
        titleTextColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "아래 이메일을 통해 Chord Play 로그인에 사용한 소셜 로그인 아이디를 보내주세요. 가입한 소셜 로그인 이메일로 인증 메일을 보내드리겠습니다. 계정이 삭제되면 닉네임, 성별, 나이 등 개인정보와 앱 내 데이터 (소유한 악보 등)이 모두 파기됩니다."),
            Container(height: 30),
            Text(
                "Please send me the social login ID you used to login to Chord Play via the email below. We will send you a verification email to the social login email that you signed up for. If the account is deleted, all personal information such as nicknames, gender, and age, and data in the app (such as music sheets owned) will be destroyed."),
            Container(height: 30),
            Text("email: chj7239@gmail.com")
          ],
        ),
      ),
    );
  }
}
