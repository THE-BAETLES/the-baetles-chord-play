import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/toggle_button.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/toggle_box.dart';

import '../../../widget/atom/app_colors.dart';

class SvgToggleButton extends StatelessWidget {
  final bool isToggled;
  final String text;
  final String iconPath;
  final double iconWidth;
  final double iconHeight;
  final Function()? onClick;

  const SvgToggleButton({
    Key? key,
    required this.isToggled,
    required this.text,
    required this.iconPath,
    this.iconWidth = 20,
    this.iconHeight = 16,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      isToggled: isToggled,
      text: text,
      onClick: onClick,
      icon: SvgPicture.asset(
        iconPath,
        width: iconWidth,
        height: iconHeight,
        fit: BoxFit.cover,
        color: isToggled ? AppColors.servePointColor2 : null,
      ),
    );
  }
}
