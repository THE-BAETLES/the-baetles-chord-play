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
  }) {
    _sortByBeatTimeInAsc(chords);
  }

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

  void _sortByBeatTimeInAsc(List<ChordBlock> chords) {
    chords.sort((ChordBlock chord1, ChordBlock chord2) {
      return ((chord1.beatTime - chord2.beatTime) * 1000).toInt();
    });
  }
}
