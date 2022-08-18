import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controller/pitch_tracker/pitch_tracker.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/remove_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/set_youtube_player_controller.dart';
import 'package:the_baetles_chord_play/presentation/performance/sheet_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/loop.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_performer.dart';
import '../../domain/use_case/update_play_state.dart';
import '../../service/conductor/performers/call_performer.dart';
import '../../service/conductor/performers/pitch_checker.dart';

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
  bool isPitchBeingChecked = false;

  YoutubePlayerController? _youtubeController;

  final AddPerformer _addPerformer;
  final UpdatePlayState _updatePlayState;
  final AddConductorPositionListener _addConductorPositionListener;
  final RemoveConductorPositionListener _removeConductorPositionListener;
  final SetYoutubePlayerController _setYoutubePlayerController;

  late final Function(PlayState) _conductorPositionCallback;

  CallPerformer callPerformer = CallPerformer();
  final PitchChecker pitchChecker = PitchChecker();

  PlayState get playState => _playState;

  SheetState? get sheetState => _sheetState;

  YoutubePlayerController? get youtubePlayerController => _youtubeController;

  PerformanceViewModel(
    this._updatePlayState,
    this._addPerformer,
    this._addConductorPositionListener,
    this._removeConductorPositionListener,
    this._setYoutubePlayerController,
  ) {
    _conductorPositionCallback = ((PlayState playState) {
      _playState = playState;
      notifyListeners();
    });


  }

  void initViewModel({
    required final Video video,
    required final SheetInfo sheetInfo,
    required final SheetData sheetData,
  }) {
    print("test1: init model!");

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

    _youtubeController = YoutubePlayerController(
      initialVideoId: video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideControls: true,
      ),
    );

    _setYoutubePlayerController(_youtubeController!);

    _updatePlayState(
      isPlaying: false,
      currentPosition: 0,
      tempo: 1.0,
      defaultBpm: sheetData.bpm,
      loop: Loop(0, -1),
      capo: 0,
    );

    callPerformer.setCallback((PlayState playState) {
      _playState = playState;
      notifyListeners();
    });
    _addPerformer(callPerformer);
    _addPerformer(pitchChecker);

    _addConductorPositionListener(_conductorPositionCallback);
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

  void dispose() {
    _removeConductorPositionListener(_conductorPositionCallback);
    _youtubeController = null;
  }

  void onClickCheckButton() {
    isPitchBeingChecked = !isPitchBeingChecked;

    if (isPitchBeingChecked) {
      pitchChecker.start();
    } else {
      pitchChecker.pause();
    }

    // notifyListeners();
  }
}
