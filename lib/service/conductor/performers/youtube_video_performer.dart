import 'package:flutter/foundation.dart';
import 'package:mutex/mutex.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/model/play_state.dart';
import '../performer_interface.dart';

class YoutubeVideoPerformer implements PerformerInterface {
  YoutubePlayerController? _controller;
  late PlayState _playState;
  String? videoId;

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

    return true;
  }

  @override
  Future<void> execute() async {

    if (_playState.isPlaying) {
      _controller!.play();
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
