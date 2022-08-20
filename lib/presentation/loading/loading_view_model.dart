import 'package:flutter/material.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/chord_block.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/triad_type.dart';
import '../../domain/model/video.dart';

class LoadingViewModel extends ChangeNotifier {
  double _progress = 0;
  SheetData? _sheetData = SheetData(id: 'imdummy', bpm: 60, chords: [
    ChordBlock(Chord(Note.fromNoteName('C3'), TriadType.major), 12, 12, 13),
    // ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 25, 12.213696067, 13.560453428),
    // ChordBlock(Chord(Note.fromNoteName('G#3'), TriadType.major), 28, 13.606893337, 14.489251608),
    // ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 30, 14.535691517, 16.997006694),
    // ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 35, 17.043446603, 18.11156451),
    // ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 300, 17.043446603, 18.11156451),
  ]);

  double get progress => _progress;

  bool get isLoaded => progress == 100;

  SheetData? get sheetData => _sheetData;

  void loadSheet(Video video, SheetInfo sheetInfo) async {
    _progress = 0;
    await Future.delayed(Duration(seconds: 1));
    _progress = 10;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _progress = 100;
    notifyListeners();
  }

  void onDispose() {
    _progress = 0;
  }
}
