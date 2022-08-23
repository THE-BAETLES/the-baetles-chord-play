import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../domain/model/chord.dart';
import '../atom/app_colors.dart';

class BeatTile extends StatelessWidget {
  final Chord? chord;
  final bool isHighlighted;
  final Color? borderColor;
  final Function()? onClick;
  final Function()? onLongClick;

  const BeatTile({
    Key? key,
    this.chord,
    this.isHighlighted = false,
    this.borderColor,
    this.onClick,
    this.onLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: GestureDetector(
          onTap: onClick,
          onLongPress: onLongClick,
          child: Container(
            width: 40,
            height: 40,
            color: isHighlighted ? AppColors.blue7F : Colors.white,
            child: Center(
              child: Text(
                chord != null ? (chord?.root.noteName)! : '',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: AppFontFamilies.pretendard,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
