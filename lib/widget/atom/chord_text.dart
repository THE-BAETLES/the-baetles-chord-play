import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import 'app_colors.dart';

class ChordText extends StatelessWidget {
  final String root;
  final String keySignature;
  final String postfix;
  final double rootSize;
  final Color rootColor;
  final double postfixSize;
  final Color postfixColor;

  const ChordText({
    Key? key,
    required this.root,
    required this.keySignature,
    required this.postfix,
    this.rootSize = 20,
    this.postfixSize = 12,
    this.rootColor = AppColors.black04,
    this.postfixColor = AppColors.black04,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          root,
          style: TextStyle(
            color: rootColor,
            height: 0.9,
            fontSize: rootSize,
            fontWeight: FontWeight.w400,
            fontFamily: AppFontFamilies.pretendard,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keySignature,
              style: TextStyle(
                color: postfixColor,
                height: 0.9,
                fontSize: postfixSize + 4,
                fontWeight: FontWeight.w500,
                fontFamily: AppFontFamilies.pretendard,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 1.0,
                maxWidth: postfixSize * 2.15,
              ),
              child: AutoSizeText(
                postfix,
                maxLines: 1,
                minFontSize: 1,
                maxFontSize: postfixSize.floorToDouble(),
                style: TextStyle(
                  color: postfixColor,
                  fontSize: postfixSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFontFamilies.pretendard,
                  letterSpacing: -1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
