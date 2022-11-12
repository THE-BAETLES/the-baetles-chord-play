import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/apple_icon.dart';

class AppleLoginButton extends StatelessWidget {
  final Function() onClick;

  const AppleLoginButton({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black04,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
        ),
        onPressed: onClick,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            AppleIcon(),
            const Center(
              child: Text(
                "Apple로 로그인",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 14,
                  color: Color.fromARGB(255, 252, 252, 252),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
