import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/play_option.dart';

abstract class ConductorInterface {
  Future<void> addPerformer(final PerformerInterface performer);
  Future<bool> syncPlayOption({
    bool? isPlaying,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  });
  Future<bool> syncPlayPosition({
    required int positionInMillis,
  });
  void addCurrentPositionListener(Function(int mSec) callBack);
  void removeCurrentPositionListener(Function(int mSec) callBack);
  PlayOption getPlayOption();
}