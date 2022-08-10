import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';

import '../../domain/model/instrument.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/get_liked_sheets_of_video.dart';
import '../../domain/use_case/get_user_id_token.dart';

class BridgeViewModel with ChangeNotifier {
  Video? _video;
  Instrument? _selectedInstrument = Instrument.guitar;
  int _tabBarOffset = 0;
  SheetInfo? _selectedSheet = null;

  // use cases
  final GetUserIdToken getUserIdToken;
  final GetSheetsOfVideo getSheetsOfVideo;
  final GetMySheetsOfVideo getMySheetsOfVideo;
  final GetLikedSheetsOfVideo getLikedSheetIdsOfVideo;

  UnmodifiableListView<SheetInfo>? _mySheets;
  UnmodifiableListView<SheetInfo>? _likedSheets;
  UnmodifiableListView<SheetInfo>? _sharedSheets;

  UnmodifiableListView<SheetInfo>? get mySheets => _mySheets;

  UnmodifiableListView<SheetInfo>? get likedSheets => _likedSheets;

  UnmodifiableListView<SheetInfo>? get sharedSheets => _sharedSheets;

  SheetInfo? get selectedSheet => _selectedSheet;

  bool get isStartButtonActivated => _selectedSheet != null;

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
    this.getUserIdToken,
    this.getSheetsOfVideo,
    this.getMySheetsOfVideo,
    this.getLikedSheetIdsOfVideo,
  );

  Future<void> onPageInit(Video video) async {
    if (this._video != video) {
      _tabBarOffset = 0;
      this._video = video;
      _loadSheets(video);
    }
  }

  void onChangeInstrument(Instrument? instrument) {
    _selectedInstrument = instrument;
  }

  Future<void> _loadSheets(Video video) async {
    _mySheets = await getMySheetsOfVideo(video.id);
    _sharedSheets = await getSheetsOfVideo(video.id);
    _likedSheets =
        await getLikedSheetIdsOfVideo((await getUserIdToken())!, video.id);

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

    Navigator.of(context).pushNamed(
      '/loading-page',
      arguments: [
        _video!,
        _selectedSheet!,
      ],
    );
  }
}