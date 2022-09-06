import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_shared_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/chord_block.dart';
import '../../domain/model/instrument.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/create_sheet.dart';
import '../../domain/use_case/generate_video.dart';
import '../../domain/use_case/get_liked_sheets_of_video.dart';
import '../../domain/use_case/get_user_id_token.dart';

class BridgeViewModel with ChangeNotifier {
  Video? _video;
  Instrument? _selectedInstrument = Instrument.guitar;
  int _tabBarOffset = 0;
  SheetInfo? _selectedSheet = null;
  YoutubePlayerController? youtubePlayerController;

  // use cases
  final GenerateVideo _generateVideo;
  final GetMySheetsOfVideo _getMySheetsOfVideo;
  final GetLikedSheetsOfVideo _getLikedSheetsOfVideo;
  final GetSharedSheetsOfVideo _getSharedSheetsOfVideo;
  final CreateSheet _createSheet;

  UnmodifiableListView<SheetInfo>? _mySheets;
  UnmodifiableListView<SheetInfo>? _likedSheets;
  UnmodifiableListView<SheetInfo>? _sharedSheets;

  UnmodifiableListView<SheetInfo>? get mySheets => _mySheets;

  UnmodifiableListView<SheetInfo>? get likedSheets => _likedSheets;

  UnmodifiableListView<SheetInfo>? get sharedSheets => _sharedSheets;

  List<ChordBlock>? chordBlocksToDuplicate = null; // 나중에 SheetBuilder로 분리

  Video? get video => _video;

  SheetInfo? get selectedSheet => _selectedSheet;

  bool get isStartButtonActivated => _selectedSheet != null;

  bool get isInputSheetDetailPopupVisible => chordBlocksToDuplicate != null;

  int get sheetCount {
    switch (_tabBarOffset) {
      case 0:
        return _mySheets?.length ?? 0;
      case 1:
        return _likedSheets?.length ?? 0;
      case 2:
        return _sharedSheets?.length ?? 0;
      default:
        return -1;
    }
  }

  Instrument? get selectedInstrument => _selectedInstrument;

  int get tabBarOffset => _tabBarOffset;

  BridgeViewModel(
    this._getMySheetsOfVideo,
    this._getLikedSheetsOfVideo,
    this._getSharedSheetsOfVideo,
    this._generateVideo,
    this._createSheet,
  );

  Future<void> onPageBuild(BuildContext context, Video video) async {
    if (this._video != video) {
      this._video = video;
      _tabBarOffset = 0;

      youtubePlayerController = YoutubePlayerController(
        initialVideoId: video.id,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          enableCaption: false,
        ),
      );

      SheetCreationDialogViewModel viewModel =
          context.read<SheetCreationDialogViewModel>();
      viewModel.addOnCompleteCallback(onCompleteSettingSheetDetail);
      viewModel.addOnCancelCallback(onCancelSettingSheetDetail);

      await _generateVideo(video);
      await _loadSheets(video);
    }
  }

  void onChangeInstrument(Instrument? instrument) {
    _selectedInstrument = instrument;
  }

  Future<void> _loadSheets(Video video) async {
    _mySheets = UnmodifiableListView(await _getMySheetsOfVideo(video.id));
    _likedSheets = UnmodifiableListView(await _getLikedSheetsOfVideo(video.id));
    _sharedSheets =
        UnmodifiableListView(await _getSharedSheetsOfVideo(video.id));

    notifyListeners();
  }

  void onChangeTabIndex(int tabIndex) {
    _tabBarOffset = tabIndex;
    notifyListeners();
  }

  void onSelectSheet(SheetInfo sheet) {
    if (_selectedSheet != sheet) {
      _selectedSheet = sheet;

      notifyListeners();
    }
  }

  void onStartButtonClicked(BuildContext context) {
    if (_selectedSheet == null) {
      assert(false);
      return;
    }

    youtubePlayerController?.pause();

    Navigator.of(context).pushNamed(
      '/loading-page',
      arguments: {
        "video": _video!,
        "sheetInfo": _selectedSheet!,
      },
    );
  }

  void onClickCreateSheetButton() {
    chordBlocksToDuplicate = [];
    notifyListeners();
  }

  void onClickCancleCreateSheetButton() {
    chordBlocksToDuplicate = null;
    notifyListeners();
  }

  void onCompleteInputSheetDetail(String title, double bpm) {
    _createSheet(
      videoId: _video!.id,
      title: title,
      bpm: bpm,
      chords: <ChordBlock>[],
    );
  }

  Future<void> onCompleteSettingSheetDetail(String title, double bpm) async {
    await _createSheet(
      videoId: _video!.id,
      title: title,
      bpm: bpm,
      chords: chordBlocksToDuplicate!,
    );

    chordBlocksToDuplicate = null;
    await _loadSheets(_video!);
  }

  void onCancelSettingSheetDetail() {
    chordBlocksToDuplicate = null;
    notifyListeners();
  }

  void reset() {
    _video = null;
    _selectedInstrument = Instrument.guitar;
    _tabBarOffset = 0;
    _selectedSheet = null;
    youtubePlayerController = null;
  }
}
