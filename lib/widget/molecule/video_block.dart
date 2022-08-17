import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/widget/molecule/music_sheet_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/play_count.dart';

import '../../domain/model/video.dart';
import '../atom/video_thumbnail.dart';

class VideoBlock extends StatelessWidget {
  final Video video;
  const VideoBlock({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 92,
      child: Row(
        children: [
          Stack(
            children: [
              VideoThumbnail(
                thumbnailPath: video.thumbnailPath,
                width: 72,
                height: 72,
              ),
            ],
          ),
          Column(
            children: [
              Text(video.title),
              Row(
                children: [
                  PlayCount(
                    count: video.playCount,
                    formatter: NumberFormat.compact(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
