import 'chord.dart';

class ChordBlock {
  final Chord chord;
  final int position;
  final double start;
  final double end;

  ChordBlock(this.chord, this.position, this.start, this.end);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChordBlock &&
          runtimeType == other.runtimeType &&
          chord == other.chord &&
          position == other.position &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode =>
      chord.hashCode ^ position.hashCode ^ start.hashCode ^ end.hashCode;
}