import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기초 셋팅"),
      ),
      body: Stack(
        children: const [
          Positioned(
            left: 30,
            child: Text(
              '사용하실 닉네임을 설정해주세요 :)',
              style: TextStyle(
                color: Color.fromARGB(255, 4, 4, 4),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
