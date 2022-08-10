import 'loop.dart';
import 'video.dart';

class PlayState {
  final bool isPlaying;
  final int currentPosition;  // millisecond
  final double tempo;
  final double defaultBpm;
  final Loop loop;
  final int capo;

  PlayState({
    required this.isPlaying,
    required this.currentPosition,
    required this.tempo,
    required this.defaultBpm,
    required this.loop,
    required this.capo,
  });

  PlayState copy({
    bool? isPlaying,
    int? currentPosition,
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
