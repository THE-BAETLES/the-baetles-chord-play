import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/play_state.dart';

abstract class ConductorInterface {
  Future<void> addPerformer(final PerformerInterface performer);
  Future<bool> syncPlayState({
    bool? isPlaying,
    int? currentPosition,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  });
  void addCurrentPositionListener(Function(PlayState) callBack);
  void removeCurrentPositionListener(Function(PlayState) callBack);
  PlayState getPlayState();
}