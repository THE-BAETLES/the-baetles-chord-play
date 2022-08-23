import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/music_sheet_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/play_count.dart';
import 'package:intl/intl.dart';

import '../../domain/model/video.dart';
import '../atom/app_colors.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  late final void Function(Video)? _onVideoClicked;

  VideoCard(
      {Key? key, required this.video, void Function(Video)? onVideoClicked})
      : super(key: key) {
    _onVideoClicked = onVideoClicked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onVideoClicked?.call(video),
      child: Container(
        width: 186,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowB5,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // header
            Container(
              child: ClipRRect(
                child: Image.network(
                  video.thumbnailPath,
                  width: 186,
                  height: 186,
                  fit: BoxFit.cover,

                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),

            // summary
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              height: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    video.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: AppFontFamilies.pretendard,
                      color: AppColors.black04,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Wrap(
                    children: [
                      PlayCount(
                        count: video.playCount,
                        formatter: NumberFormat.compact(),
                      ),
                      Container(width: 20),
                      MusicSheetCount(
                        count: 0,
                        formatter: NumberFormat.compact(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
