import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:intl/intl.dart';

class MusicSheetCount extends StatelessWidget {
  final int count;
  final NumberFormat formatter;

  const MusicSheetCount({required this.count, required this.formatter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_music_sheet.svg',
          width: 12,
          height: 9.6,
        ),
        const SizedBox(width: 4),
        Text(
          formatter.format(count),
          style: TextStyle(
            fontSize: 11,
            fontFamily: AppFontFamilies.pretendard,
            color: AppColors.gray80,
          ),
        ),
      ],
    );
  }
}
