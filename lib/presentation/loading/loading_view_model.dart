import 'package:flutter/material.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/chord_block.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/triad_type.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/create_sheet.dart';
import '../../domain/use_case/get_sheet_data.dart';

class LoadingViewModel extends ChangeNotifier {
  final GetSheetData _getSheetData;

  double _progress = 0;
  SheetData? _sheetData;

  double get progress => _progress;
  bool get isLoaded => progress == 100;
  SheetData? get sheetData => _sheetData;

  LoadingViewModel(this._getSheetData);

  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _sheetData = await _getSheetData(sheetInfo.id);

    if (_sheetData == null) {
      print("start sse");
      // sse 로 불러오기!
    } else {
      _progress = 100;
      notifyListeners();
    }
  }

  void onDispose() {
    _progress = 0;
    _sheetData = null;
  }
}
