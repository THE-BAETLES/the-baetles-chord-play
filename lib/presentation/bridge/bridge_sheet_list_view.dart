import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';

import '../../domain/model/sheet_info.dart';
import '../../widget/molecule/sheet_info_card.dart';
import 'bridge_view_model.dart';

class BridgeSheetListView extends StatefulWidget {
  final UnmodifiableListView<SheetInfo>? sheets;
  final String videoTitle;

  BridgeSheetListView(
      {Key? key, required this.sheets, required this.videoTitle})
      : super(key: key);

  @override
  State<BridgeSheetListView> createState() => _BridgeSheetListViewState();
}

class _BridgeSheetListViewState extends State<BridgeSheetListView> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.sheets?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        BridgeViewModel viewModel = context.watch<BridgeViewModel>();
        SheetInfo sheet = widget.sheets![index];

        return SheetInfoCard(
          sheetTitle: sheet.title,
          videoTitle: widget.videoTitle,
          ownerUserId: sheet.userId,
          likeCount: sheet.likeCount,
          backgroundColor: viewModel.selectedSheet == sheet
              ? AppColors.whiteF8
              : Colors.white,
          onClicked: () {
            viewModel.onSelectSheet(sheet);
          },
        );
      },
    );
  }
}
