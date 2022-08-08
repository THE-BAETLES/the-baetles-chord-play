import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../domain/model/play_state.dart';

class ConductorService {
  static const msecPerSec = 1000;

  final List<PerformerInterface> _performers = [];
  late PlayState _playState;

  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    presetMillisecond: 0,
  );

  PlayState get playState => _playState =
      _playState.copy(currentPosition: stopWatchTimer.rawTime.value);

  Future<bool> setPlayState(final PlayState playState) async {
    _playState = playState;

    // performer들에게 playState 전파
    List<Future<bool>> tasks = [];

    for (PerformerInterface performer in _performers) {
      tasks.add(performer.syncPlayStateAndReady(playState));
    }

    for (Future<bool> task in tasks) {
      bool isReadySuccessful = await task;

      if (!isReadySuccessful) {
        return false;
      }
    }

    for (PerformerInterface performer in _performers) {
      performer.execute();
    }

    // stop watch 동기화
    stopWatchTimer.onExecute.add(
      playState.isPlaying ? StopWatchExecute.start : StopWatchExecute.stop,
    );

    stopWatchTimer.setPresetSecondTime(
      (_playState.currentPosition / _playState.tempo).toInt(),
    );

    return true;
  }

  Future<void> addPerformer(final PerformerInterface performer) async {
    performer.syncPlayStateAndReady(_playState);

    // TODO : 연주 도중에 추가해도 정상적으로 sync 되도록 개선

    _performers.add(performer);
  }

  PlayState updateCurrentTimeByStopWatchValue() {
    return _playState = _playState.copy(
      currentPosition: (stopWatchTimer.rawTime.value * _playState.tempo) as int,
    );
  }
}
