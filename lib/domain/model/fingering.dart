import 'chord.dart';
import 'finger_position.dart';

class Fingering {
  final Chord chord;
  final List<FingerPosition> positions;

  Fingering({
    required this.chord,
    required this.positions,
  });
}
