import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_shared_sheets_of_video.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/chord_block.dart';
import '../../domain/model/instrument.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/create_sheet_duplication.dart';
import '../../domain/use_case/generate_video.dart';
import '../../domain/use_case/get_liked_sheets_of_video.dart';

class BridgeViewModel with ChangeNotifier {
  Video? _video;
  Instrument? _selectedInstrument = Instrument.guitar;
  int _tabBarOffset = 0;
  YoutubePlayerController? _youtubePlayerController;
  final ValueNotifier<bool> _isCreatingSheet = ValueNotifier(false);
  final ValueNotifier<bool> _isSettingSheet = ValueNotifier(false);
  SheetInfo? _sheetToDuplicate;

  UnmodifiableListView<SheetInfo>? _mySheets;
  UnmodifiableListView<SheetInfo>? _likedSheets;
  UnmodifiableListView<SheetInfo>? _sharedSheets;

  // use cases
  final GenerateVideo _generateVideo;
  final GetMySheetsOfVideo _getMySheetsOfVideo;
  final GetLikedSheetsOfVideo _getLikedSheetsOfVideo;
  final GetSharedSheetsOfVideo _getSharedSheetsOfVideo;
  final CreateSheetDuplication _createSheet;

  UnmodifiableListView<SheetInfo>? get mySheets => _mySheets;
  UnmodifiableListView<SheetInfo>? get likedSheets => _likedSheets;
  UnmodifiableListView<SheetInfo>? get sharedSheets => _sharedSheets;
  Video? get video => _video;
  YoutubePlayerController? get youtubePlayerController => _youtubePlayerController;
  ValueNotifier<bool> get isCreatingSheet => _isCreatingSheet;
  ValueNotifier<bool> get isSettingSheet => _isSettingSheet;

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
    if (_video != video) {
      _video = video;
      _tabBarOffset = 0;

      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: video.id,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          enableCaption: false,
        ),
      );


      SheetCreationDialogViewModel viewModel =
          context.read<SheetCreationDialogViewModel>();
      viewModel.addOnCompleteCallback(onCompleteSettingSheetDetail);
      viewModel.addOnCancelCallback(onCancleCreatingSheet);

      await _generateVideo(video);
      await _loadSheets(video);

      _tabBarOffset = _findNotEmptyTabIndex();
      notifyListeners();
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
  }

  int _findNotEmptyTabIndex() {
    if (_mySheets != null && _mySheets!.isNotEmpty) {
      return 0;
    } else if (_likedSheets != null && _likedSheets!.isNotEmpty) {
      return 1;
    } else {
      return 2;
    }
  }

  void onChangeTabIndex(int tabIndex) {
    _tabBarOffset = tabIndex;
    notifyListeners();
  }

  void onSelectSheet(BuildContext context, SheetInfo sheet) {
    _youtubePlayerController?.pause();

    Navigator.of(context).pushNamed(
      '/loading-page',
      arguments: {
        "video": _video!,
        "sheetInfo": sheet,
      },
    );
  }

  void onClickCreateSheetButton(BuildContext context) {
    _isCreatingSheet.value = true;
  }

  void onCancleCreatingSheet() {
    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;
  }

  void onSelectSheetToDuplicate(SheetInfo sheetInfo) {
    _sheetToDuplicate = sheetInfo;
    _isSettingSheet.value = true;
  }


  Future<void> onCompleteSettingSheetDetail(String title) async {
    await _createSheet(
      sheetId: _sheetToDuplicate?.id ?? "",
      title: title,
    );

    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;

    await _loadSheets(_video!);
    notifyListeners();
  }

  void onCancelSettingSheetDetail() {
    notifyListeners();
  }

  void reset() {
    _video = null;
    _selectedInstrument = Instrument.guitar;
    _tabBarOffset = 0;
    _youtubePlayerController = null;
    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;
    _sheetToDuplicate = null;
  }
}
