import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/presentation/performance/sheet_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_performer.dart';
import '../../domain/use_case/set_play_state.dart';
import '../../service/conductor/performers/youtube_video_performer.dart';

class PerformanceViewModel with ChangeNotifier {
  late PlayState _playState;
  late SheetState _sheetState;
  late YoutubeVideoPerformer _youtubeVideoPerformer;

  final AddPerformer _addPerformer;
  final SetPlayState _setPlayState;

  PlayState get playState => _playState;

  YoutubePlayerController get youtubePlayerController =>
      _youtubeVideoPerformer.controller;

  SheetState get sheetState => _sheetState;

  PerformanceViewModel(this._setPlayState, this._addPerformer) {
    _playState = PlayState(
      isPlaying: false,
      currentPosition: 0,
      tempo: 1,
      defaultBpm: 80,
      loop: Loop(0, -1),
      capo: 0,
    );
    _setPlayState(_playState); // conductor 기본 play option 설정

    _youtubeVideoPerformer = YoutubeVideoPerformer(YoutubePlayerController(
        initialVideoId: 'f6YDKF0LVWw',
        flags: YoutubePlayerFlags(autoPlay: false)));
    Future.microtask(() => _addPerformer(_youtubeVideoPerformer));
  }

  void initViewModel({
    required final Video video,
    required final SheetInfo sheetInfo,
    required final SheetData sheetData,
  }) {
    print("hi 1");
    _playState = PlayState(
      isPlaying: false,
      currentPosition: 0,
      tempo: 1.0,
      defaultBpm: sheetData.bpm,
      loop: Loop(0, -1),
      capo: 0,
    );

    _sheetState = SheetState(
      sheetInfo: sheetInfo,
      sheetData: sheetData,
    );

    print("hi 2");
    _playState = _playState.copy(currentPosition: 0, isPlaying: false);
    _setPlayState(_playState);

    _youtubeVideoPerformer.controller.cue(video.id);

    print("hi 3");
  }

  void play({int? playAt}) {
    _playState = _playState.copy(isPlaying: true, currentPosition: playAt);
    _setPlayState(_playState);
  }
}
