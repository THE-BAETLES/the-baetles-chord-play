import 'loop.dart';
import 'video.dart';

class PlayOption {
  final bool isPlaying;
  final double tempo;
  final double defaultBpm;
  final Loop loop;
  final int capo;

  PlayOption({
    required this.isPlaying,
    required this.tempo,
    required this.defaultBpm,
    required this.loop,
    required this.capo,
  });

  double get bps => defaultBpm / 60.0;

  double get spb => 1.0 / bps;

  PlayOption copy({
    bool? isPlaying,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) {
    return PlayOption(
      isPlaying: isPlaying ?? this.isPlaying,
      tempo: tempo ?? this.tempo,
      defaultBpm: defaultBpm ?? this.defaultBpm,
      loop: loop ?? this.loop,
      capo: capo ?? this.capo,
    );
  }
}
