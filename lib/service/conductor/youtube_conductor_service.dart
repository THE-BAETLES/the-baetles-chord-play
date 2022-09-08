import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mutex/mutex.dart';

import 'package:the_baetles_chord_play/domain/model/loop.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/play_option.dart';

class YoutubeConductorService implements ConductorInterface {
  static const Duration syncPeriod = Duration(milliseconds: 30);

  final List<PerformerInterface> performers = [];
  YoutubePlayerController? _youtubeController;

  final Mutex lock = Mutex();

  late PlayOption _playOption;
  final ValueNotifier<int> _currentPosition = ValueNotifier(0); // ms
  final List<Function(int)> _onPositionChangeCallbacks = [];
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
          _currentPosition.value =
              _youtubeController!.value.position.inMilliseconds;

          log("current position : ${_youtubeController!.value.position.inMilliseconds}");

          for (Function callback in _onPositionChangeCallbacks) {
            callback(_currentPosition.value);
          }
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

  Future<bool> _syncYoutubeController(YoutubePlayerController controller, PlayOption playOption, int playPosition) async {
    // youtube controller play state 적용
    if (!(_youtubeController!.value.isReady)) {
      return false;
    }

    _youtubeController!.setPlaybackRate(playOption.tempo);

    if (playOption.isPlaying) {
      _youtubeController!.load(
        _youtubeController!.initialVideoId,
        startAt: playPosition ~/ 1000,
      );
      log("youtube player start playing");
    } else {
      _youtubeController!.seekTo(
        Duration(milliseconds: playPosition),
      );
      _youtubeController!.pause();
      log("youtube player stop playing");
    }

    return true;
  }
}
