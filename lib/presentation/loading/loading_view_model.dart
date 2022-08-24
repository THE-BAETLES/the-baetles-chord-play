import 'package:flutter/foundation.dart';
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
  SheetInfo? _sheetInfo;
  SheetData? _sheetData;

  double get progress => _progress;

  bool get isLoaded => progress == 100;

  SheetData? get sheetData => _sheetData;

  SheetInfo? get sheetInfo => _sheetInfo;

  LoadingViewModel(this._getSheetData);

  void onProgressHandler(SSEModel event) {
    print("SSE Progress Event");
    String? status = event.data?.trim();

    if (kDebugMode) {
      print("SSE progress event listen! - status : $status");
    }

    if (status == "1") {
      _progress = 33.3;
    } else if (status == "2") {
      _progress = 66.6;
    } else if (status == "3") {
      _progress = 99.9;
      // ProgressService().stop();

      (() async {
        SheetClient client =
            RestClientFactory().getClient(RestClientType.sheet) as SheetClient;
        _sheetData = (await client.getSheetData(_sheetInfo!.id)).toSheetData();
        _progress = 100;
        notifyListeners();
      })();
    }

    notifyListeners();
  }

  void sseDoneHandler() async {
    if (kDebugMode) {
      print("SSE done");
    }
  }

  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _sheetInfo = sheetInfo;
    _sheetData = await _getSheetData(sheetInfo.id);
    if (_sheetData == null) {
      // _sheetData = SheetData(
      //   id: '1234567',
      //   bpm: 60,
      //   chords: [
      //     ChordBlock(
      //       Chord.fromString("C2:maj"),
      //       4,
      //       4,
      //       5,
      //     ),
      //     ChordBlock(
      //       Chord.fromString("C2:maj"),
      //       5,
      //       5,
      //       6,
      //     ),
      //     ChordBlock(
      //       Chord.fromString("C2:maj"),
      //       6,
      //       6,
      //       7,
      //     ),
      //     ChordBlock(
      //       Chord.fromString("C2:maj"),
      //       7,
      //       7,
      //       8,
      //     ),
      //     ChordBlock(
      //       Chord.fromString("C2:maj"),
      //       8,
      //       8,
      //       9,
      //     ),
      //     ChordBlock(
      //       Chord.fromString("C3:maj"),
      //       12,
      //       12,
      //       13,
      //     ),
      //   ],
      // );
      // _progress = 100;
      // notifyListeners();
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
