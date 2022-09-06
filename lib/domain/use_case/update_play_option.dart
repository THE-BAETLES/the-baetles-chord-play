import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import '../model/loop.dart';

class UpdatePlayOption {
  final ConductorInterface _conductor;

  UpdatePlayOption(this._conductor);

  Future<void> call({
    bool? isPlaying,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) async {
    _conductor.syncPlayOption(
      isPlaying: isPlaying,
      tempo: tempo,
      defaultBpm: defaultBpm,
      loop: loop,
      capo: capo,
    );
  }
}
