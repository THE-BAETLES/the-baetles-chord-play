import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';

import '../../domain/model/sheet_info.dart';
import '../../widget/molecule/like_count.dart';
import '../../widget/molecule/sheet_info_card.dart';
import 'bridge_view_model.dart';

class BridgeSheetListView extends StatefulWidget {
  final UnmodifiableListView<SheetInfo>? sheets;
  final String videoTitle;
  final Function(BuildContext, SheetInfo)? onClick;

  BridgeSheetListView({
    Key? key,
    required this.sheets,
    required this.videoTitle,
    this.onClick,
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

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: SheetInfoCard(
                  sheetTitle: sheet.title,
                  videoTitle: widget.videoTitle,
                  ownerUserId: sheet.userId,
                  likeCount: sheet.likeCount,
                  backgroundColor: Colors.white,
                  onClicked: () {
                    widget.onClick?.call(context, sheet);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                    width: 40,
                    child: Column(
                      children: [
                        LikeCount(
                          count: sheet.likeCount,
                          width: 20,
                          space: 12,
                          color: (true) ? AppColors.redFF : AppColors.gray80,
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}
