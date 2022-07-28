import 'dart:collection';

import 'package:flutter/material.dart';

import '../../domain/model/sheet_music.dart';
import '../../domain/model/video.dart';
import 'bridge_sheet_list_view.dart';

class BridgeSheetTabView extends StatefulWidget {
  final UnmodifiableListView<UnmodifiableListView<SheetMusic>?> sheets;
  final Video video;
  final void Function(int)? onTabIndexChanged;

  const BridgeSheetTabView({
    Key? key,
    required this.video,
    required this.sheets,
    this.onTabIndexChanged,
  }) : super(key: key);

  @override
  State<BridgeSheetTabView> createState() => _BridgeSheetTabViewState();
}

class _BridgeSheetTabViewState extends State<BridgeSheetTabView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.sheets.length, vsync: this);

    _tabController.addListener(() {
      widget.onTabIndexChanged?.call(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
        children: widget.sheets
            .map((sheet) => BridgeSheetListView(
                videoTitle: widget.video.title, sheets: sheet))
            .toList());
  }
}
