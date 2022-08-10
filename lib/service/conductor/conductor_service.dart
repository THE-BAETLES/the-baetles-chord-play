import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/play_state.dart';

class ConductorService {
  static final PlayState defaultPlayState = PlayState(
    isPlaying: false,
    currentPosition: 0,
    tempo: 1.0,
    defaultBpm: 80,
    loop: Loop(0, -1),
    capo: 0,
  );

  final List<PerformerInterface> _performers = [];
  PlayState _playState = defaultPlayState;
  final List<Function(PlayState)> _playStateListeners = [];

  late final StopWatchTimer stopWatchTimer;

  final Mutex lock = Mutex();

  PlayState get playState => _playState = _playState.copy(
      currentPosition:
          (stopWatchTimer.rawTime.value * _playState.tempo).toInt());

  int get currentPosition =>
      (stopWatchTimer.rawTime.value * _playState.tempo).toInt();

  ConductorService() {
    stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countUp,
        presetMillisecond: 0,
        onChangeRawSecond: (int second) {
          _playState = _playState.copy(
              currentPosition: (second * 1000 * _playState.tempo).toInt());
        });
  }

  void addPlayStateListener(void Function(PlayState) listener) {
    _playStateListeners.add(listener);
  }

  Future<bool> updatePlayState({
    bool? isPlaying,
    int? currentPosition,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) async {
    await lock.acquire();

    try {
      PlayState priorPlayState =   _playState;

      _playState = _playState.copy(
        isPlaying: isPlaying,
        currentPosition: currentPosition,
        tempo: tempo,
        defaultBpm: defaultBpm,
        loop: loop,
        capo: capo,
      );

      List<Future<bool>> tasks = [];

      for (PerformerInterface performer in _performers) {
        // performer에게 playState 전파
        tasks.add(performer.syncPlayStateAndReady(playState));
      }

      stopWatchTimer.onExecute.add(
        StopWatchExecute.stop,
      );

      for (Future<bool> task in tasks) {
        bool isReadySuccessful = await task;

        if (!isReadySuccessful) {
          _playState = priorPlayState;
          return false;
        }
      }

      for (PerformerInterface performer in _performers) {
        performer.execute();
      }

      // stop watch 동기화
      stopWatchTimer.setPresetTime(
        mSec : _playState.currentPosition ~/ _playState.tempo,
        add: false,
      );

      stopWatchTimer.onExecute.add(
        playState.isPlaying ? StopWatchExecute.start : StopWatchExecute.stop,
      );

      for (void Function(PlayState) listener in _playStateListeners) {
        listener(_playState);
      }
    } finally {
      lock.release();
    }

    return true;
  }

  Future<void> addPerformer(final PerformerInterface performer) async {
    _performers.add(performer);
    await updatePlayState(currentPosition: currentPosition);
  }
}
