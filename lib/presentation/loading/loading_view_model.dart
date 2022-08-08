import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/model/chord.dart';
import 'package:the_baetles_chord_play/domain/model/chord_block.dart';
import 'package:the_baetles_chord_play/domain/model/sheet_data.dart';

import '../../domain/model/note.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/triad_type.dart';
import '../../domain/model/video.dart';

class LoadingViewModel extends ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;

  loadSheet(BuildContext context, Video video, SheetInfo sheetInfo) async {
    _progress = 0;
    await Future.delayed(Duration(seconds: 2));
    _progress = 10;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _progress = 100;
    notifyListeners();
    await Future.delayed(Duration(microseconds: 100));
    Navigator.of(context).popAndPushNamed("/performance-page", arguments: [
      video,
      sheetInfo,
      SheetData(bpm: 30, chords: [ChordBlock(Chord(Note(30), TriadType.minor), 0, 2.5234, 3.25332)]),
    ]);
  }
}
