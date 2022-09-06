import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/play_count.dart';

import '../../domain/model/video.dart';
import '../atom/app_colors.dart';

class VideoSummary extends StatelessWidget {
  final Video video;
  final int titleMaxLines;
  final double width;

  const VideoSummary({
    Key? key,
    required this.video,
    required this.titleMaxLines,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                width: constraints.maxWidth,
                child: Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppFontFamilies.pretendard,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: titleMaxLines,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${video.singer} | ${video.genre}",
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: AppFontFamilies.notosanskr,
                  color: AppColors.gray80,
                ),
              ),
              PlayCount(
                count: video.playCount,
                formatter: NumberFormat("#,###"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
