import 'loop.dart';
import 'video.dart';

class PlayState {
  final bool isPlaying;
  int _currentPosition;  // millisecond. don't change this
  final double tempo;
  final double defaultBpm;
  final Loop loop;
  final int capo;

  PlayState({
    required this.isPlaying,
    required int currentPosition,
    required this.tempo,
    required this.defaultBpm,
    required this.loop,
    required this.capo,
  }) : _currentPosition = currentPosition;

  int get currentPosition => _currentPosition;

  double get bps => defaultBpm / 60.0;

  double get spb => 1.0 / bps;

  int setCurrentPosition(int value, {bool isAdded = false}) {
    if (isAdded) {
      _currentPosition += value;
    } else {
      _currentPosition = value;
    }

    return _currentPosition;
  }

  PlayState copy({
    bool? isPlaying,
    int? currentPosition, // millisecond
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) {
    return PlayState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      tempo: tempo ?? this.tempo,
      defaultBpm: defaultBpm ?? this.defaultBpm,
      loop: loop ?? this.loop,
      capo: capo ?? this.capo,
    );
  }
}
