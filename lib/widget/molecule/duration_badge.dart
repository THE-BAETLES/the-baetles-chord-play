import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/utility/time_formatter.dart';

import '../../domain/model/video.dart';
import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';

class DurationBadge extends StatelessWidget {
  static const none = 0;
  final Duration duration;

  const DurationBadge({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.black00,
      ),
      child: Text(
        TimeFormatter.formatDurationToHms(duration),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: AppFontFamilies.pretendard,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
    );
  }
}
