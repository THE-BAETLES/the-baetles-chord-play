import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import '../model/loop.dart';

class UpdatePlayState {
  final ConductorInterface _conductorService;

  UpdatePlayState(this._conductorService);

  Future<void> call({
    bool? isPlaying,
    int? currentPosition,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) async {
    _conductorService.updatePlayState(
      isPlaying: isPlaying,
      currentPosition: currentPosition,
      tempo: tempo,
      defaultBpm: defaultBpm,
      loop: loop,
      capo: capo,
    );
  }
}
