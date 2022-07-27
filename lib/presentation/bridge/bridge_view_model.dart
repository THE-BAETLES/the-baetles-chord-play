import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';

import '../../domain/model/instrument.dart';
import '../../domain/model/sheet_music.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/get_liked_sheets_of_video.dart';
import '../../domain/use_case/get_user_id_token.dart';

class BridgeViewModel with ChangeNotifier {
  Video? _video;
  Instrument? _selectedInstrument = Instrument.guitar;

  // use cases
  final GetUserIdToken getUserIdToken;
  final GetSheetsOfVideo getSheetsOfVideo;
  final GetMySheetsOfVideo getMySheetsOfVideo;
  final GetLikedSheetsOfVideo getLikedSheetIdsOfVideo;

  UnmodifiableListView<SheetMusic>? _mySheets;
  UnmodifiableListView<SheetMusic>? _likedSheets;
  UnmodifiableListView<SheetMusic>? _sharedSheets;

  UnmodifiableListView<SheetMusic>? get mySheets => _mySheets;

  UnmodifiableListView<SheetMusic>? get likedSheets => _likedSheets;

  UnmodifiableListView<SheetMusic>? get sharedSheets => _sharedSheets;

  Instrument? get selectedInstrument => _selectedInstrument;

  BridgeViewModel(
    this.getUserIdToken,
    this.getSheetsOfVideo,
    this.getMySheetsOfVideo,
    this.getLikedSheetIdsOfVideo,
  );

  Future<void> onPageInit(Video video) async {
    this._video = video;
    _loadSheets(video);
  }

  void onSelectInstrument(Instrument instrument) {
    _selectedInstrument = instrument;
  }

  Future<void> _loadSheets(Video video) async {
    _mySheets = await getMySheetsOfVideo(video.id);
    _sharedSheets = await getSheetsOfVideo(video.id);
    _likedSheets =
        await getLikedSheetIdsOfVideo((await getUserIdToken())!, video.id);

    notifyListeners();
  }
}
