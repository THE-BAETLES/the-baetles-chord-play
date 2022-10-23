import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';


class UserInfoView extends StatelessWidget {
  late final String userNickname;

  UserInfoView({
    Key? key,
    required this.userNickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      userNickname,
      style: const TextStyle(
        fontSize: 12,
        fontFamily: AppFontFamilies.pretendard,
        fontWeight: FontWeight.w400,
        color: AppColors.gray73,
      ),
    );
  }
}
