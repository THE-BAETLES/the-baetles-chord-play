import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mutex/mutex.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/play_state.dart';

class ConductorService {
  // TODO : 전체적인 리팩토링 및 코드 정리 필요
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

  int startTime = 0;
  late final StopWatchTimer stopWatchTimer;

  final Mutex lock = Mutex();

  int get currentTime => (startTime + stopWatchTimer.rawTime.value);

  PlayState get playState => _playState = _playState.copy(
      currentPosition: (currentTime * _playState.tempo).toInt());

  int get currentPosition => (currentTime * _playState.tempo).toInt();

  ConductorService() {
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      presetMillisecond: 0,
      onChange: (int mSec) {
        _playState.setCurrentPosition(
            ((startTime + mSec) * _playState.tempo).toInt());
        // print("test1: listen - ${_playState.currentPosition} ${mSec}");
        for (Function(PlayState) listener in _playStateListeners) {
          listener(_playState);
        }
      },
      onChangeRawSecond: (int second) {
        // print("second : ${second}");
      },
    );
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
      PlayState priorPlayState = _playState;

      _playState = _playState.copy(
        isPlaying: isPlaying,
        currentPosition: currentPosition ?? this.currentPosition,
        tempo: tempo,
        defaultBpm: defaultBpm,
        loop: loop,
        capo: capo,
      );

      stopWatchTimer.onExecute.add(StopWatchExecute.stop);

      List<Future<bool>> tasks = [];

      for (PerformerInterface performer in _performers) {
        // performer에게 playState 전파
        tasks.add(performer.syncPlayStateAndReady(_playState));
      }

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

      print(
          "test1: preset to ${_playState.currentPosition ~/ _playState.tempo}");
      print("test1: real value : ${stopWatchTimer.rawTime.value}");

      // stop watch 동기화
      // TODO : currentPosition 반영하도록 변경
      startTime = currentPosition ?? currentTime;
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);

      if (playState.isPlaying) {
        stopWatchTimer.onExecute.add(StopWatchExecute.start);
      }

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

  void addPlayStateListener(void Function(PlayState) listener) {
    // playState가 변화할 때마다 호출될 listener들을 등록함.
    _playStateListeners.add(listener);
  }

  ValueStream<int> getRawTime() {
    return stopWatchTimer.rawTime;
  }
}
