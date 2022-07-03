import 'note.dart';

class ChordBlock {
  final Note chord;
  final int position;
  final double start;
  final double end;

  ChordBlock(this.chord, this.position, this.start, this.end);
}