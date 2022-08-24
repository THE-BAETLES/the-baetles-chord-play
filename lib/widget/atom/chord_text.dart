import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import 'app_colors.dart';

class ChordText extends StatelessWidget {
  final String root;
  final String postfix;
  final Color rootColor;
  final Color postfixColor;

  const ChordText({
    Key? key,
    required this.root,
    required this.postfix,
    this.rootColor = AppColors.black04,
    this.postfixColor = AppColors.black04,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: root,
            style: TextStyle(
              color: rootColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamilies.pretendard,
            ),
          ),
          TextSpan(
            text: postfix,
            style: TextStyle(
              color: postfixColor,
              fontSize: 9,
              fontWeight: FontWeight.w500,
              fontFamily: AppFontFamilies.pretendard,
            ),
          ),
        ],
      ),
    );
  }
}
