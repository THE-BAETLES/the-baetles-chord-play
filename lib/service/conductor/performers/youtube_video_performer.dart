import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/model/play_state.dart';
import '../performer_interface.dart';

class YoutubeVideoPerformer implements PerformerInterface {
  final YoutubePlayerController _controller;
  late PlayState _playState; // TODO : Observer 패턴으로 변경하기

  YoutubePlayerController get controller => _controller;

  YoutubeVideoPerformer(this._controller);

  @override
  Future<bool> syncPlayStateAndReady(PlayState playState) async {
    _playState = playState;

    _controller.cue(
      _controller.initialVideoId,
      startAt: playState.currentPosition,
    );

    _controller.updateValue(_controller.value.copyWith(
      position: Duration(milliseconds: playState.currentPosition),
      playbackRate: playState.tempo,
    ));

    while (!(_controller.value.playerState == PlayerState.cued)) {
      Future.delayed(Duration(milliseconds: 100));
    }

    return true;
  }

  @override
  Future<void> execute() async {
    if (_playState.isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    throw UnimplementedError();
  }
}
