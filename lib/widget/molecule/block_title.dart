import 'package:flutter/material.dart';

import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';

class BlockTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  const BlockTitle({required this.title, this.subTitle = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: AppFontFamilies.pretendard,
              color: AppColors.black04,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 15),
          child: Text(
            subTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              fontFamily: AppFontFamilies.pretendard,
              color: AppColors.gray9D,
            ),
          ),
        ),
      ],
    );
  }
}
