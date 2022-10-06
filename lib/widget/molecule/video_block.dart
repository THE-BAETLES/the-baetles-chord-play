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

  const VideoBlock({Key? key, required this.video, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call(video);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        height: 90,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints contstraints) {
            return Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: VideoThumbnail(
                        thumbnailPath: video.thumbnailPath,
                        width: 72,
                        height: 72,
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
                  child: VideoSummary(
                    video: video,
                    titleMaxLines: 2,
                    width: 10,
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
