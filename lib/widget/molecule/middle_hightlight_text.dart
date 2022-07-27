import 'package:flutter/cupertino.dart';

import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';

class MiddleHighlightText extends StatelessWidget {
  final String leftText;
  final String middleText;
  final String rightText;

  const MiddleHighlightText({
    Key? key,
    required this.leftText,
    required this.middleText,
    required this.rightText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: leftText,
              style: TextStyle(
                color: AppColors.black04,
                fontSize: 14,
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
              )),
          TextSpan(
              text: middleText,
              style: TextStyle(
                color: AppColors.blue4E,
                fontSize: 14,
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
              )),
          TextSpan(
              text: rightText,
              style: TextStyle(
                color: AppColors.black04,
                fontSize: 14,
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
