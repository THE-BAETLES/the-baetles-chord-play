import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/like_count.dart';
import 'package:the_baetles_chord_play/widget/molecule/user_info_view.dart';

import '../atom/app_colors.dart';

class SheetInfoCard extends StatelessWidget {
  final String sheetTitle;
  final String videoTitle;
  final String ownerUserId;
  final int likeCount;
  final Color? backgroundColor;
  final void Function()? onClicked;

  const SheetInfoCard({
    Key? key,
    required this.sheetTitle,
    required this.videoTitle,
    required this.ownerUserId,
    required this.likeCount,
    this.backgroundColor,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked?.call(),
      child: Container(
        color: backgroundColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Container(width: 15),
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
                      Text(
                        videoTitle,
                        style: TextStyle(
                          color: AppColors.gray80,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFontFamilies.pretendard,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: UserInfoView(
                          userNickname: "baetles",
                          userProfileImagePath:
                              "https://avatars.githubusercontent.com/u/40628765?v=4",
                        ),
                      ),
                      LikeCount(
                        count: likeCount,
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
