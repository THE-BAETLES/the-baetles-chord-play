import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:mutex/mutex.dart';

import 'package:the_baetles_chord_play/domain/model/loop.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/play_option.dart';

class YoutubeConductorService implements ConductorInterface {
  static const Duration syncPeriod = Duration(milliseconds: 16);

  final List<PerformerInterface> performers = [];
  YoutubePlayerController? _youtubeController;

  final Mutex lock = Mutex();
  final Mutex loopCheckLock = Mutex();

  late PlayOption _playOption;
  final ValueNotifier<int> _currentPosition = ValueNotifier(0); // ms
  final Set<Function(int)> _onPositionChangeCallbacks = {};
  Timer? _timer;

  YoutubeConductorService({required final PlayOption initialPlayOption}) {
    _playOption = initialPlayOption;

    syncPlayOption();
  }

  Future<void> setYoutubeController(
    final YoutubePlayerController controller,
  ) async {
    _youtubeController = controller;
    await syncPlayOption();
    await syncPlayPosition(positionInMillis: _currentPosition.value);
  }

  @override
  Future<void> addPerformer(PerformerInterface performer) async {
    performers.add(performer);
    performer.onAttachConductor(this);
    await syncPlayOption();
  }

  @override
  Future<bool> syncPlayOption({
    bool? isPlaying,
    double? tempo,
    double? defaultBpm,
    Loop? loop,
    int? capo,
  }) async {
    await lock.acquire();

    if (_youtubeController == null) {
      return false;
    }

    try {
      PlayOption newPlayOption = _playOption.copy(
        isPlaying: isPlaying,
        tempo: tempo,
        defaultBpm: defaultBpm,
        loop: loop,
        capo: capo,
      );

      _syncPlayOptionWithPerformers(performers, newPlayOption);

      _syncYoutubeController(_youtubeController!, newPlayOption, _currentPosition.value);

      _playOption = newPlayOption;
    } on Exception {
      if (kDebugMode) {
        print("Youtube conductor service: error");
      }
    } finally {
      lock.release();
    }

    return true;
  }

  @override
  Future<bool> syncPlayPosition({
    required int positionInMillis,
  }) async {
    await lock.acquire();

    if (_youtubeController == null) {
      return false;
    }

    _currentPosition.value = positionInMillis;
    _syncYoutubeController(_youtubeController!, _playOption, _currentPosition.value);

    lock.release();
    return true;
  }

  @override
  void addCurrentPositionListener(Function(int) callBack) {
    _onPositionChangeCallbacks.add(callBack);

    if (_onPositionChangeCallbacks.length == 1) {
      // 주기적으로 currentPosition과 youtubeController.position 동기화
      _timer = Timer.periodic(syncPeriod, (timer) {
        if (!lock.isLocked && _youtubeController != null) {
          () async {
            await lock.acquire();

            _currentPosition.value =
                _youtubeController!.value.position.inMilliseconds;

            for (Function callback in _onPositionChangeCallbacks) {
              callback(_currentPosition.value);
            }

            lock.release();
          }();
        }
      });
    }
  }

  @override
  void removeCurrentPositionListener(Function(int) callBack) {
    bool isRemoved = _onPositionChangeCallbacks.remove(callBack);

    if (isRemoved && _onPositionChangeCallbacks.isEmpty) {
      _timer?.cancel();
    }
  }

  @override
  PlayOption getPlayOption() {
    return _playOption;
  }

  Future<bool> _syncPlayOptionWithPerformers(List<PerformerInterface> performers, PlayOption playOption) async {
    final List<Future<bool>> syncTasks = [];

    // play state 전파
    for (PerformerInterface performer in performers) {
      syncTasks.add(performer.syncPlayOptionAndReady(playOption));
    }

    // performer 적용 완료 대기
    for (int taskIdx = 0; taskIdx < syncTasks.length; ++taskIdx) {
      bool isReadySuccessful = await syncTasks[taskIdx];

      if (!isReadySuccessful) {
        // TODO : 대기 상태 취소
        return false;
      }
    }

    return true;
  }

  bool _syncYoutubeController(YoutubePlayerController controller, PlayOption playOption, int playPosition) {
    // youtube controller play state 적용
    if (!(controller.value.isReady)) {
      log("youtube player is not ready (error code ${controller.value.errorCode})");
      return false;
    }

    controller.setPlaybackRate(playOption.tempo);

    if (playOption.isPlaying) {
      controller.seekTo(
        Duration(milliseconds: playPosition),
      );
    } else {
      controller.seekTo(
        Duration(milliseconds: playPosition),
      );
      controller.pause();
      log("youtube controller stop playing");
    }

    if (playOption.loop.isInfinite()) {
      removeCurrentPositionListener(_boundPosition);
    } else {
      addCurrentPositionListener(_boundPosition);
    }

    return true;
  }

  void _boundPosition(int currentPosition) async {
    if (loopCheckLock.isLocked) {
      return;
    }

    await loopCheckLock.acquire();

    if (_playOption.loop.isInfinite()) {
      return;
    }

    if (currentPosition < _playOption.loop.start) {
      _youtubeController!.seekTo(Duration(milliseconds: _playOption.loop.start));
    } else if (currentPosition >= _playOption.loop.end - 1000) {
      _youtubeController!.seekTo(Duration(milliseconds: _playOption.loop.start));
    } else {
      log("YoutubeConductorService: loop checked but not looped ${math.min(_playOption.loop.end, _youtubeController!.value.metaData.duration.inMilliseconds)} ${_playOption.loop.toString()}");
    }

    loopCheckLock.release();
  }
}
