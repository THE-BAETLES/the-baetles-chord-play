import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controller/pitch_tracker/pitch_tracker.dart';
import 'package:the_baetles_chord_play/domain/model/chord_block.dart';
import 'package:the_baetles_chord_play/domain/model/play_option.dart';
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
import '../../domain/use_case/move_play_position.dart';
import '../../domain/use_case/update_play_option.dart';
import '../../service/conductor/performers/call_performer.dart';
import '../../service/conductor/performers/chord_checker.dart';

class PerformanceViewModel with ChangeNotifier {
  final PlayOption initPlayOption = PlayOption(
    isPlaying: false,
    tempo: 1.0,
    defaultBpm: 80,
    loop: Loop(0, -1),
    capo: 0,
  );
  late final ValueNotifier<PlayOption> _playOption;
  final ValueNotifier<int> _currentPosition = ValueNotifier(0);  // in millisecond
  final ValueNotifier<bool> _isPitchBeingChecked = ValueNotifier(false);
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);
  final Set<int> correctIndexes = {};
  final Set<int> wrongIndexes = {};
  SheetState? _sheetState;
  int? _editingPosition;
  final ValueNotifier<YoutubePlayerController?> _youtubeController = ValueNotifier(null);
  late final Function(int) _conductorPositionCallback;

  final AddPerformer _addPerformer;
  final UpdatePlayOption _updatePlayOption;
  final SetPlayPosition _setPlayPosition;
  final AddConductorPositionListener _addConductorPositionListener;
  final RemoveConductorPositionListener _removeConductorPositionListener;
  final SetYoutubePlayerController _setYoutubePlayerController;


  PlayOptionCallbackPerformer _callbackPerformer = PlayOptionCallbackPerformer();
  ChordChecker? _chordChecker;

  ValueNotifier<PlayOption> get playOption => _playOption;
  ValueNotifier<int> get currentPosition => _currentPosition;
  ValueNotifier<bool> get isMuted => _isMuted;
  ValueNotifier<bool> get isPitchBeingChecked => _isPitchBeingChecked;
  SheetState? get sheetState => _sheetState;
  bool get isEditing => _editingPosition != null;
  Note? get editingRoot => (_sheetState?.sheetData.chords.cast<ChordBlock?>())?.firstWhere((element) => element?.position == _editingPosition, orElse: () => null)?.chord.root;
  ValueNotifier<YoutubePlayerController?> get youtubePlayerController => _youtubeController;

  PerformanceViewModel(
    this._updatePlayOption,
    this._setPlayPosition,
    this._addPerformer,
    this._addConductorPositionListener,
    this._removeConductorPositionListener,
    this._setYoutubePlayerController,
  ) {
    _conductorPositionCallback = ((int position) {
      _currentPosition.value = position;
      notifyListeners();
    });

    _playOption = ValueNotifier(initPlayOption);
  }

  void initViewModel({
    required final Video video,
    required final SheetInfo sheetInfo,
    required final SheetData sheetData,
  }) {
    _playOption.value = PlayOption(
      isPlaying: false,
      tempo: 1.0,
      defaultBpm: sheetData.bpm,
      loop: Loop(0, -1),
      capo: 0,
    );

    _sheetState = SheetState(
      sheetInfo: sheetInfo,
      sheetData: sheetData,
    );

    _youtubeController.value = YoutubePlayerController(
      initialVideoId: video.id,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideControls: true,
        mute: isMuted.value,
      ),
    );

    _setYoutubePlayerController(_youtubeController.value!);

    _setPlayPosition(position: 0);

    _updatePlayOption(
      isPlaying: _playOption.value.isPlaying,
      tempo: _playOption.value.tempo,
      defaultBpm: _playOption.value.defaultBpm,
      loop: _playOption.value.loop,
      capo: _playOption.value.capo,
    );

    _callbackPerformer.setCallback((PlayOption playOption) {
      _playOption.value = playOption;
      notifyListeners();
    });

    _addPerformer(_callbackPerformer);

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

  void play() {
    _updatePlayOption(isPlaying: true);
  }

  void stop() {
    _updatePlayOption(isPlaying: false);
  }

  void moveCurrentPosition(int amount) {
    int dest = _currentPosition.value + amount;

    if (dest < 0) {
      dest = 0;
    }

    _setPlayPosition(position: dest);
  }

  void onTileClick(int tileIndex) {
    double bps = _playOption.value.defaultBpm / 60.0;
    double spb = 1 / bps;
    _setPlayPosition(position: (tileIndex * spb).toInt() * 1000);
  }

  void onTileLongClick(int tileIndex) {
    _editingPosition = tileIndex;
    notifyListeners();
  }

  void reset() {
    _removeConductorPositionListener(_conductorPositionCallback);
    _updatePlayOption(
      isPlaying: initPlayOption.isPlaying,
      tempo: initPlayOption.tempo,
      defaultBpm: initPlayOption.defaultBpm,
      loop: initPlayOption.loop,
      capo: initPlayOption.capo,
    );
    _youtubeController.value = null;
    _chordChecker?.pause();
    _isPitchBeingChecked.value = false;
    _isMuted.value = false;
  }

  void onCheckButtonClicked() {
    _isPitchBeingChecked.value = !_isPitchBeingChecked.value;

    if (_isPitchBeingChecked.value) {
      _chordChecker?.start();
    } else {
      _chordChecker?.pause();
    }

    notifyListeners();
  }

  void onMuteButtonClicked() {
    _isMuted.value = !_isMuted.value;

    if (_isMuted.value) {
      youtubePlayerController.value?.mute();
    } else {
      youtubePlayerController.value?.unMute();
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
