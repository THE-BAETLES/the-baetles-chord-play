import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../atom/app_colors.dart';

class AddSheetButton extends StatelessWidget {
  final void Function()? onClick;

  const AddSheetButton({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/ic_add_sheet.svg",
            width: 16,
            height: 16,
          ),
          Container(width: 5),
          const Text(
            "내 악보 생성하기",
            style: TextStyle(
              color: AppColors.gray80,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamilies.pretendard,
            ),
          ),
        ],
      ),
    );
  }
}
