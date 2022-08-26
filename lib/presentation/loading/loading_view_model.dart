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
    // _sheetData = await _getSheetData(sheetInfo.id);
    if (_sheetData == null) {
      _sheetData = SheetData(id: "1234", bpm: 117, chords: [
        ChordBlock(
          Chord.fromString("E3:maj"),
          0,
          0,
          1,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          4,
          4,
          5,
        ),
        ChordBlock(
          Chord.fromString("B3:maj"),
          8,
          8,
          9,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          12,
          12,
          13,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          16,
          16,
          17,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          20,
          20,
          21,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          24,
          24,
          25,
        ),
        ChordBlock(
          Chord.fromString("B3:maj"),
          27,
          27,
          28,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          28,
          28,
          29,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          32,
          32,
          33,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          36,
          36,
          37,
        ),
        ChordBlock(
          Chord.fromString("B3:maj"),
          40,
          40,
          41,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          44,
          44,
          45,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          48,
          48,
          49,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          52,
          52,
          53,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          56,
          56,
          57,
        ),
        ChordBlock(
          Chord.fromString("B3:maj"),
          59,
          59,
          60,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          60,
          60,
          61,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          64,
          64,
          65,
        ),
        ChordBlock(
          Chord.fromString("G3:maj"),
          66,
          66,
          67,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          68,
          68,
          69,
        ),
        ChordBlock(
          Chord.fromString("C3:maj"),
          70,
          70,
          71,
        ),
        ChordBlock(
          Chord.fromString("D3:maj"),
          72,
          72,
          73,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          76,
          76,
          77,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          80,
          80,
          81,
        ),
        ChordBlock(
          Chord.fromString("A3:maj"),
          84,
          84,
          85,
        ),
        ChordBlock(
          Chord.fromString("B3:maj"),
          88,
          88,
          89,
        ),
        ChordBlock(
          Chord.fromString("E3:maj"),
          92,
          92,
          93,
        ),
      ]);
      _progress = 100;
      notifyListeners();
      // ProgressService().start(video.id, onProgressHandler, sseDoneHandler);
    } else {
      _progress = 100;
      notifyListeners();
    }
  }

  void reset() {
    _progress = 0;
    _sheetData = null;
  }
}
