import 'package:flutter/material.dart';

import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';

class LoadingViewModel extends ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;

  bool get isLoaded => progress == 100;

  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _progress = 0;
    await Future.delayed(Duration(seconds: 1));
    _progress = 10;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _progress = 100;
    notifyListeners();
  }
}
