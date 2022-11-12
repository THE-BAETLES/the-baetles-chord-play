import 'package:flutter/foundation.dart';

import 'chord.dart';
import 'finger_position.dart';

class Fingering {
  final Chord chord;
  final List<FingerPosition> positions;

  Fingering({
    required this.chord,
    required this.positions,
  }) {
    if (kDebugMode) {
      List<bool> isAppear = List.filled(6, false);

      for (FingerPosition position in positions) {
        assert(!isAppear[position.stringNumber - 1]);
      }
    }
  }

  String get positionString {
    List<String> result = List.filled(6, 'x');

    for (final position in positions) {
      if (position.fret == -1) {
        continue;
      }

      result[position.stringNumber - 1] = position.fret.toString();
    }

    print(result.join(" "));
    return result.join(" ");
  }
}
