import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';

import '../../domain/model/sheet_info.dart';
import '../../widget/molecule/like_count.dart';
import '../../widget/molecule/sheet_info_card.dart';
import 'bridge_view_model.dart';

class BridgeSheetListView extends StatefulWidget {
  final List<SheetInfo>? sheets;
  final String videoTitle;
  final Function(BuildContext, SheetInfo)? onClick;
  final Function(BuildContext, SheetInfo)? onLongClicked;
  final Function(SheetInfo)? onClickLikeButton;
  final double itemHeight;

  BridgeSheetListView({
    Key? key,
    required this.sheets,
    required this.videoTitle,
    this.onClick,
    this.onLongClicked,
    this.onClickLikeButton,
    this.itemHeight = 110,
  }) : super(key: key);

  @override
  State<BridgeSheetListView> createState() => _BridgeSheetListViewState();
}

class _BridgeSheetListViewState extends State<BridgeSheetListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.sheets?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        SheetInfo sheet = widget.sheets![index];

        return Column(
          children: [
            Container(
              color: Colors.white,
              height: widget.itemHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          widget.onClick?.call(context, sheet);
                        },
                        onLongPress: () {
                          widget.onLongClicked?.call(context, sheet);
                        },
                        child: Ink(
                          color: Colors.white,
                          padding:
                              EdgeInsets.only(left: 15, top: 10, bottom: 10),
                          child: SheetInfoCard(
                            sheetTitle: sheet.title,
                            videoTitle: widget.videoTitle,
                            ownerUserNickname: sheet.userNickname,
                            likeCount: sheet.likeCount,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        widget.onClickLikeButton?.call(sheet);
                      },
                      child: Ink(
                        padding: EdgeInsets.only(right: 10),
                        width: 70,
                        height: widget.itemHeight,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LikeCount(
                              count: sheet.likeCount,
                              width: 20,
                              height: 20,
                              space: 15,
                              color: sheet.liked
                                  ? AppColors.redFF
                                  : AppColors.gray80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              color: AppColors.grayF5,
            ),
          ],
        );
      },
    );
  }
}
