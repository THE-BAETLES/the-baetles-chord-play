import '../../service/conductor/conductor_service.dart';
import '../model/loop.dart';
import '../model/play_state.dart';

class UpdatePlayState {
  final ConductorService _conductorService;

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
