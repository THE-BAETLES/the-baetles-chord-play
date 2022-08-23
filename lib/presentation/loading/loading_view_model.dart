import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';
import 'package:the_baetles_chord_play/router/sheet/sheet_client.dart';
import 'package:the_baetles_chord_play/service/progress_service.dart';

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
  
  void onProgressHandler(SSEModel event){
    String? status = event.data;
    if(status == "1"){
      _progress = 33.3;
    }else if(status == "2"){
      _progress = 66.6;
    }else if(status == "3"){
      _progress = 99.9;
    }
    notifyListeners();
  }
  
  void sseDoneHandler() async {
    SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;
    _sheetData = (await client.getAISheet()).toSheetData();
    ProgressService().stop();
    notifyListeners();
  }
  
  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _sheetData = await _getSheetData(sheetInfo.id);
    if (_sheetData == null) {
      ProgressService().start(video.id, onProgressHandler, sseDoneHandler);
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
