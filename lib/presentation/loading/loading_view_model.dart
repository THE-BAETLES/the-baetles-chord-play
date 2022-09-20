import 'dart:developer';

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
  static final onCompleteDownload = "1";
  static final onCompleteExtraction = "2";
  static final onCompleteGeneration = "3";

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
    log("SSE Progress Event");
    String? status = event.data?.trim();

    if (kDebugMode) {
      log("SSE progress event listen! - status : $status");
    }

    if (status == onCompleteDownload) {
      _setAndNotifyProgressValue(50);
    } else if (status == onCompleteExtraction) {
      _setAndNotifyProgressValue(70);
    } else if (status == onCompleteGeneration) {
      _setAndNotifyProgressValue(90);

      (() async {
        SheetClient client =
            RestClientFactory().getClient(RestClientType.sheet) as SheetClient;
        _sheetData = (await client.getSheetData(_sheetInfo!.id)).toSheetData();
        _setAndNotifyProgressValue(100);
      })();
    }
  }

  void sseDoneHandler() async {
    if (kDebugMode) {
      print("SSE done");
    }
  }

  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _setAndNotifyProgressValue(1);

    _sheetInfo = sheetInfo;
    // data for test below (to be deleted later)
    _sheetData = SheetData(id: 'imdummy', bpm: 60, chords: [
      ChordBlock(Chord(Note.fromNoteName('C3'), TriadType.major), 12, 12, 13),
      ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 25, 12.213696067, 13.560453428),
      ChordBlock(Chord(Note.fromNoteName('G#3'), TriadType.major), 28, 13.606893337, 14.489251608),
      ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 30, 14.535691517, 16.997006694),
      ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 35, 17.043446603, 18.11156451),

      ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 50, 14.535691517, 16.997006694),
      ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 70, 17.043446603, 18.11156451),
    ]);
    _setAndNotifyProgressValue(100);

    return;


    _sheetData = await _getSheetData(sheetInfo.id);

    _setAndNotifyProgressValue(10);

    if (_sheetData == null) {
      ProgressService().start(video.id, onProgressHandler, sseDoneHandler);
    } else {
      _setAndNotifyProgressValue(100);
    }
  }

  void reset() {
    _progress = 0;
    _sheetData = null;
  }

  void _setAndNotifyProgressValue(double value) {
    _progress = value;
    notifyListeners();
  }
}
