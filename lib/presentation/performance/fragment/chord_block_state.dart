import 'package:the_baetles_chord_play/domain/model/chord.dart';

import '../../../domain/model/beat_accuracy.dart';

class ChordBlockState {
  final BeatAccuracy? beatAccuracy;
  final Chord? chord;
  final int startPositionInMillis;
  final int endPositionInMillis;

  ChordBlockState({
    this.beatAccuracy,
    this.chord,
    required this.startPositionInMillis,
    required this.endPositionInMillis,
  });

  double getStartOffset(double bpm, {int startBeatPositionInMillis = 0}) {
    double spb = _calcSpb(bpm);
    return (startPositionInMillis - startBeatPositionInMillis) / spb;
  }

  double getEndOffset(double bpm, {int startBeatPositionInMillis = 0}) {
    double spb = _calcSpb(bpm);
    return (endPositionInMillis - startBeatPositionInMillis) / spb;
  }

  double _calcSpb(double bpm) {
    return 60.0 / bpm;
  }
}
