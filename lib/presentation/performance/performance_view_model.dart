import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_play_state_listener.dart';
import 'package:the_baetles_chord_play/presentation/performance/sheet_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_performer.dart';
import '../../domain/use_case/update_play_state.dart';
import '../../service/conductor/performers/youtube_video_performer.dart';

class PerformanceViewModel with ChangeNotifier {
  PlayState _playState = PlayState(
    isPlaying: false,
    currentPosition: 0,
    tempo: 1,
    defaultBpm: 80,
    loop: Loop(0, -1),
    capo: 0,
  );

  SheetState? _sheetState;
  late YoutubeVideoPerformer _youtubeVideoPerformer;

  final AddPerformer _addPerformer;
  final UpdatePlayState _updatePlayState;
  final AddPlayStateListener _addPlayStateListener;

  PlayState get playState => _playState;

  YoutubePlayerController? get youtubePlayerController =>
      _youtubeVideoPerformer.controller;

  SheetState? get sheetState => _sheetState;

  PerformanceViewModel(
    this._updatePlayState,
    this._addPerformer,
    this._addPlayStateListener,
  ) {
    _youtubeVideoPerformer = YoutubeVideoPerformer(null);

    _addPerformer(_youtubeVideoPerformer);

    _addPlayStateListener((final PlayState playState) {
      this._playState = playState;
      notifyListeners();
    });
  }

  void initViewModel({
    required final Video video,
    required final SheetInfo sheetInfo,
    required final SheetData sheetData,
  }) {
    _playState = PlayState(
      isPlaying: false,
      currentPosition: 0,
      tempo: 1.0,
      defaultBpm: sheetData.bpm,
      loop: Loop(0, -1),
      capo: 0,
    );

    _updatePlayState(
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

    _youtubeVideoPerformer.setController(
      YoutubePlayerController(
        initialVideoId: video.id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: false,
        ),
      ),
    );

    notifyListeners();
  }

  void play({int? playAt}) {
    _updatePlayState(isPlaying: true, currentPosition: playAt);
  }

  void stop({int? stopAt}) {
    _updatePlayState(isPlaying: false, currentPosition: stopAt);
  }

  void moveCurrentPosition(int amount) {
    int dest = _playState.currentPosition + amount;

    if (dest < 0) {
      dest = 0;
    }

    _updatePlayState(currentPosition: dest);
  }

  void onTileClick(int tileIndex) {
    double bps = _playState.defaultBpm / 60.0;
    double spb = 1 / bps;
    _updatePlayState(currentPosition: (tileIndex * spb).toInt() * 1000);
  }

  void onTileLongClick(int tileIndex) {
    // TODO : 코드 변경
  }
}
