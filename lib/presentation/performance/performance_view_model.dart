import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controller/pitch_tracker/pitch_tracker.dart';
import 'package:the_baetles_chord_play/domain/model/chord_block.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/remove_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/set_youtube_player_controller.dart';
import 'package:the_baetles_chord_play/presentation/performance/sheet_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/loop.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_performer.dart';
import '../../domain/use_case/update_play_state.dart';
import '../../service/conductor/performers/call_performer.dart';
import '../../service/conductor/performers/chord_checker.dart';

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
  bool _isPitchBeingChecked = false;
  bool _isMuted = false;
  int? _editingPosition;

  YoutubePlayerController? _youtubeController;

  final AddPerformer _addPerformer;
  final UpdatePlayState _updatePlayState;
  final AddConductorPositionListener _addConductorPositionListener;
  final RemoveConductorPositionListener _removeConductorPositionListener;
  final SetYoutubePlayerController _setYoutubePlayerController;
  final Set<int> correctIndexes = {};
  final Set<int> wrongIndexes = {};

  late final Function(PlayState) _conductorPositionCallback;

  CallPerformer _callPerformer = CallPerformer();
  ChordChecker? _chordChecker;

  PlayState get playState => _playState;
  SheetState? get sheetState => _sheetState;
  bool get isMuted => _isMuted;
  bool get isPitchBeingChecked => _isPitchBeingChecked;
  bool get isEditing => _editingPosition != null;
  Note? get editingRoot => (_sheetState?.sheetData.chords.cast<ChordBlock?>())?.firstWhere((element) => element?.position == _editingPosition, orElse: () => null)?.chord.root;

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
      flags: YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideControls: true,
        mute: isMuted,
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

    _callPerformer.setCallback((PlayState playState) {
      _playState = playState;
      notifyListeners();
    });
    _addPerformer(_callPerformer);

    _chordChecker = ChordChecker(sheetData);
    _chordChecker?.setOnCorrectCallback((correctPosition) {
      correctIndexes.add(correctPosition);
      wrongIndexes.remove(correctPosition);
      notifyListeners();
    });
    _chordChecker?.setOnWrongCallback((wrongPosition) {
      wrongIndexes.add(wrongPosition);
      correctIndexes.remove(wrongPosition);
      notifyListeners();
    });
    _addPerformer(_chordChecker!);

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
    _editingPosition = tileIndex;
    notifyListeners();
  }

  void reset() {
    _removeConductorPositionListener(_conductorPositionCallback);
    _youtubeController = null;
    _chordChecker?.pause();

    _isPitchBeingChecked = false;
    _isMuted = false;
  }

  void onCheckButtonClicked() {
    _isPitchBeingChecked = !_isPitchBeingChecked;

    if (_isPitchBeingChecked) {
      _chordChecker?.start();
    } else {
      _chordChecker?.pause();
    }

    notifyListeners();
  }

  void onMuteButtonClicked() {
    _isMuted = !_isMuted;

    if (_isMuted) {
      youtubePlayerController?.mute();
    } else {
      youtubePlayerController?.unMute();
    }

    notifyListeners();
  }

  void onCancelEdit() {
    _editingPosition = null;
  }

  void onApplyEdit(Chord chord) {
    int? index = _sheetState!.sheetData.chords.indexWhere((element) => element.position >= _editingPosition!);

    double spb = 1 / (_sheetState!.sheetData.bpm / 60.0);
    ChordBlock newChord = ChordBlock(chord, _editingPosition!, _editingPosition! * spb, (_editingPosition! + 1) * spb);

    if (index == -1) {
      _sheetState?.sheetData.chords.add(newChord);
    } else if (_sheetState!.sheetData.chords[index].position == _editingPosition) {
      _sheetState?.sheetData.chords[index] = newChord;
    } else {
      _sheetState?.sheetData.chords.insert(index, newChord);
    }

    _editingPosition = null;
  }
}
