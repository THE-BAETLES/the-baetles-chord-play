import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../domain/model/chord.dart';
import '../atom/app_colors.dart';

class BeatTile extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final bool isHighlighted;
  final Color? borderColor;
  final Function()? onClick;
  final Function()? onLongClick;

  const BeatTile({
    Key? key,
    required this.width,
    required this.height,
    this.child,
    this.isHighlighted = false,
    this.borderColor,
    this.onClick,
    this.onLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 0,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          print("tappp!!!");
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: GestureDetector(
            onTap: onClick,
            onLongPress: onLongClick,
            child: Container(
              width: width,
              height: height,
              color: isHighlighted ? AppColors.blue7F : Colors.white,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
