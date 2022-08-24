import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/app_text_styles.dart';

class TranspositionButton extends StatelessWidget {
  const TranspositionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.gray3E,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 79,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/ic_minus.svg",
                      color: AppColors.blue9C,
                    ),
                    Container(
                      width: 43,
                      alignment: Alignment.center,
                      child: Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/ic_plus.svg",
                      color: AppColors.blue9C,
                    ),
                  ],
                ),
              ),
              Text(
                "Key",
                style: AppTextStyles.controlButtonTextStyle.copyWith(
                  color: AppColors.gray9B,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
