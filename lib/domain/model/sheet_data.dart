import 'chord_block.dart';

class SheetData {
  final String id;
  final double bpm;
  final List<ChordBlock> chords;

  double get bps => bpm / 60.0;

  SheetData({
    required this.id,
    required this.bpm,
    required this.chords,
  });

  SheetData copy({
    String? id,
    double? bpm,
    List<ChordBlock>? chords,
  }) {
    return SheetData(
      id: id ?? this.id,
      bpm: bpm ?? this.bpm,
      chords: chords ?? this.chords,
    );
  }
}
