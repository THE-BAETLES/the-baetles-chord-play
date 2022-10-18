import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/duration_badge.dart';
import 'package:the_baetles_chord_play/widget/molecule/music_sheet_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/play_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_summary.dart';

import '../../domain/model/video.dart';
import '../atom/app_colors.dart';
import '../atom/video_thumbnail.dart';

class VideoBlock extends StatelessWidget {
  final Video video;
  final Function(Video)? onClick;

  const VideoBlock({
    Key? key,
    required this.video,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call(video);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 92,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.black,
                        child: VideoThumbnail(
                          thumbnailPath: video.thumbnailPath,
                          width: 75,
                          height: 75,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      child: DurationBadge(
                        duration: Duration(milliseconds: video.length),
                      ),
                      bottom: 4,
                      right: 4,
                    ),
                  ],
                ),
                Container(
                  width: 14,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: VideoSummary(
                      video: video,
                      titleMaxLines: 2,
                      width: 10,
                      titleTextStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
