import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:the_baetles_chord_play/service/progress_service.dart';

import '../../domain/use_case/get_sheet_data.dart';

class LoadingViewModel extends ChangeNotifier {
  static const onCompleteDownload = "1";
  static const onCompleteExtraction = "2";
  static const onCompleteGeneration = "3";

  final GetSheetData _getSheetData;

  double _progress = 0;

  Function()? _onCompleteLoading;

  double get progress => _progress;

  bool get isLoaded => progress == 100;

  LoadingViewModel(this._getSheetData);

  void _onProgressHandler(SSEModel event) {
    String? status = event.data?.trim();
    log("SSE progress event listen - status : $status");

    if (status == onCompleteDownload) {
      _setAndNotifyProgressValue(50);
    } else if (status == onCompleteExtraction) {
      _setAndNotifyProgressValue(70);
    } else if (status == onCompleteGeneration) {
      _setAndNotifyProgressValue(90);

      (() async {
        _setAndNotifyProgressValue(100);
        _onCompleteLoading!.call();
      })();
    }
  }

  void _sseDoneHandler() async {
    log("SSE done");
  }

  void loadSheet(String videoId, Function() onCompleteLoading) async {
    _setAndNotifyProgressValue(1);
    _onCompleteLoading = onCompleteLoading;

    // region data for test below (to be deleted later)
    // _sheetData = SheetData(id: 'imdummy', bpm: 60, chords: [
    //   ChordBlock(Chord(Note.fromNoteName('C3'), TriadType.major), 12, 12, 13),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 25, 12.213696067, 13.560453428),
    //   ChordBlock(Chord(Note.fromNoteName('G#3'), TriadType.major), 28, 13.606893337, 14.489251608),
    //   ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 30, 14.535691517, 16.997006694),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 35, 17.043446603, 18.11156451),
    //
    //   ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 50, 14.535691517, 16.997006694),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 70, 17.043446603, 18.11156451),
    //   ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 90, 14.535691517, 16.997006694),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 100, 17.043446603, 18.11156451),
    //   ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 110, 14.535691517, 16.997006694),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 120, 17.043446603, 18.11156451),
    //
    //   ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 200, 14.535691517, 16.997006694),
    //   ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 250, 17.043446603, 18.11156451),
    // 'chord': 'A#3:min'
    //
    // {코드}{옥타브}:{triad}
    //
    // * triads
    //
    // 'min'
    // 'maj'
    // 'min7'
    // 'maj7'
    // ''



    // ]);
    // _setAndNotifyProgressValue(100);
    // return;
    // endregion

    // _sheetData = await _getSheetData(sheetInfo.id);

    _setAndNotifyProgressValue(10);

    ProgressService().start(videoId, _onProgressHandler, _sseDoneHandler);
  }

  void reset() {
    _progress = 0;
  }

  void _setAndNotifyProgressValue(double value) {
    _progress = value;
    notifyListeners();
  }
}
