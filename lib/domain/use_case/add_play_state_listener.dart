import '../../service/conductor/conductor_service.dart';
import '../model/play_state.dart';

class AddPlayStateListener {
  final ConductorService _conductorService;

  AddPlayStateListener(this._conductorService);

  void call(Function(PlayState playState) onPlayStateChange) {
    _conductorService.addPlayStateListener(onPlayStateChange);
  }
}