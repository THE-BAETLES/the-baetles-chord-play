import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/user_info_view.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_thumbnail.dart';

import 'like_count.dart';

class VideoSheetItem extends StatelessWidget {
  final String thumbnailPath;
  final double height;

  final String sheetTitle;
  final String videoTitle;
  final bool isLiked;
  final int likeCount;

  const VideoSheetItem({
    Key? key,
    required this.thumbnailPath,
    required this.height,
    required this.sheetTitle,
    required this.videoTitle,
    required this.isLiked,
    required this.likeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: VideoThumbnail(
              thumbnailPath: thumbnailPath,
              width: height,
              height: height,
            ),
          ),
          Container(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _videoTitle(videoTitle),
                _sheetTitle(sheetTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoTitle(String videoTitle) {
    return Text(
      videoTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: AppColors.gray80,
        fontFamily: AppFontFamilies.pretendard,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _sheetTitle(String sheetTitle) {
    return Text(
      sheetTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: AppColors.black04,
        fontFamily: AppFontFamilies.pretendard,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
