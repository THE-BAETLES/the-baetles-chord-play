import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/like_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/user_info_view.dart';

import '../atom/app_colors.dart';

class SheetInfoCard extends StatelessWidget {
  final String sheetTitle;
  final String videoTitle;
  final String ownerUserNickname;
  final int likeCount;
  final Color? backgroundColor;
  final void Function()? onClicked;
  final void Function()? onLongClicked;

  const SheetInfoCard({
    Key? key,
    required this.sheetTitle,
    required this.videoTitle,
    required this.ownerUserNickname,
    required this.likeCount,
    this.backgroundColor,
    this.onClicked,
    this.onLongClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked?.call(),
      onLongPress: () => onLongClicked?.call(),
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Text(
                        sheetTitle,
                        style: TextStyle(
                          color: AppColors.black04,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFontFamilies.pretendard,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        height: 4,
                      ),
                      Container(
                        height: 26,
                        child: Text(
                          videoTitle,
                          style: TextStyle(
                            color: AppColors.gray80,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFontFamilies.pretendard,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 13,
                  ),
                  UserInfoView(
                    userNickname: ownerUserNickname,
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
