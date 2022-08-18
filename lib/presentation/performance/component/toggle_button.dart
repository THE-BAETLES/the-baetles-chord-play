import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/app_text_styles.dart';

class ToggleButton extends StatelessWidget {
  final bool isToggled;
  final String text;
  final String iconPath;
  final Function()? onClick;

  const ToggleButton({
    Key? key,
    required this.isToggled,
    required this.text,
    required this.iconPath,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 49,
        height: 38,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.gray3E,
              border: isToggled ? Border.all(color: AppColors.blue9C) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: SvgPicture.asset(iconPath),
                ),
                Text(
                  text,
                  style: AppTextStyles.controlButtonTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
