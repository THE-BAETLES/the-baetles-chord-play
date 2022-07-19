import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import 'app_colors.dart';

class SignUpTextStyle {

  static const TextStyle h1 = TextStyle(
    color: AppColors.gray04,
    fontFamily: AppFontFamilies.pretendard,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static const TextStyle inputText = TextStyle(
    color: AppColors.blue4E,
    fontFamily: AppFontFamilies.pretendard,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const TextStyle wrongInputText = TextStyle(
    color: AppColors.redFF,
    fontFamily: AppFontFamilies.pretendard,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const TextStyle hintText = TextStyle(
    color: AppColors.grayD2,
    fontFamily: AppFontFamilies.pretendard,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
}