import '../../service/conductor/conductor_service.dart';
import '../model/play_state.dart';

class SetPlayState {
  final ConductorService _conductorService;

  SetPlayState(this._conductorService);

  Future<void> call(final PlayState playState) async {
    _conductorService.setPlayState(playState);
  }
}