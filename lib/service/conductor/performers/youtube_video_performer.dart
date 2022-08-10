import 'package:flutter/foundation.dart';
import 'package:mutex/mutex.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/model/play_state.dart';
import '../performer_interface.dart';

class YoutubeVideoPerformer implements PerformerInterface {
  YoutubePlayerController? _controller;
  PlayState? _playState;

  YoutubePlayerController? get controller => _controller;

  YoutubeVideoPerformer(this._controller);

  @override
  Future<bool> syncPlayStateAndReady(PlayState playState) async {
    if (_controller == null) {
      return false;
    }

    if (!_controller!.value.isReady) {
      _controller!.reload();
    }

    _playState = playState;

    _controller!.cue(
      _controller!.initialVideoId,
      startAt: playState.currentPosition,
    );

    _controller!.setPlaybackRate(playState.tempo);

    await Future.delayed(const Duration(milliseconds: 300));

    print("after sync state : ${_controller!.value.playerState.toString()}");
    // return _controller!.value.playerState == PlayerState.unStarted ||
    //     _controller!.value.playerState == PlayerState.cued;
    return true;
  }

  @override
  Future<void> execute() async {
    if (_playState!.isPlaying) {
      _controller!.seekTo(Duration(milliseconds: _playState!.currentPosition));
    } else {
      _controller!.pause();
    }
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  void setController(YoutubePlayerController controller) {
    _controller = controller;
    _controller!.reload();
  }
}
