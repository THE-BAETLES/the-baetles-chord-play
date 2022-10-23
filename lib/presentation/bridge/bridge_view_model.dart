import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/data/repository/collection_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/delete_sheet.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_sheets_of_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_shared_sheets_of_video.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/chord_block.dart';
import '../../domain/model/instrument.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/triad_type.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/create_sheet_duplication.dart';
import '../../domain/use_case/generate_video.dart';
import '../../domain/use_case/get_liked_sheets_of_video.dart';
import '../../domain/use_case/get_sheet_data.dart';
import '../../domain/use_case/get_user_id.dart';

class BridgeViewModel with ChangeNotifier {
  Video? _video;
  Instrument? _selectedInstrument = Instrument.guitar;
  int _tabBarOffset = 0;
  YoutubePlayerController? _youtubePlayerController;
  SheetInfo? _sheetToDelete;
  SheetInfo? _sheetToDuplicate;
  bool _shouldRoute = false;
  String? _routeName;
  Object? _routeArguments;

  final ValueNotifier<bool> _isCreatingSheet = ValueNotifier(false);
  final ValueNotifier<bool> _isSettingSheet = ValueNotifier(false);
  final ValueNotifier<bool> _isDeletingSheet = ValueNotifier(false);
  final ValueNotifier<bool> _isVideoIncludedInCollection = ValueNotifier(false);

  UnmodifiableListView<SheetInfo>? _mySheets;
  UnmodifiableListView<SheetInfo>? _likedSheets;
  UnmodifiableListView<SheetInfo>? _sharedSheets;

  // use cases
  final GenerateVideo _generateVideo;
  final GetMySheetsOfVideo _getMySheetsOfVideo;
  final GetLikedSheetsOfVideo _getLikedSheetsOfVideo;
  final GetSharedSheetsOfVideo _getSharedSheetsOfVideo;
  final CreateSheetDuplication _createSheet;
  final DeleteSheet _deleteSheet;
  final GetSheetData _getSheetData;
  final GetUserId _getUserId;

  UnmodifiableListView<SheetInfo>? get mySheets => _mySheets;

  UnmodifiableListView<SheetInfo>? get likedSheets => _likedSheets;

  UnmodifiableListView<SheetInfo>? get sharedSheets => _sharedSheets;

  Video? get video => _video;

  YoutubePlayerController? get youtubePlayerController =>
      _youtubePlayerController;

  ValueNotifier<bool> get isCreatingSheet => _isCreatingSheet;

  ValueNotifier<bool> get isSettingSheet => _isSettingSheet;

  ValueNotifier<bool> get isDeletingSheet => _isDeletingSheet;

  ValueNotifier<bool> get isVideoIncludedInCollection =>
      _isVideoIncludedInCollection;

  bool get shouldRoute => _shouldRoute;

  String? get routeName => _routeName;

  Object? get routeArguments => _routeArguments;

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
    this._deleteSheet,
    this._getSheetData,
    this._getUserId,
  );

  Future<void> onPageBuild(BuildContext context, Video video) async {
    if (_video?.id == video.id) {
      return;
    }

    video = await _generateVideo(video);
    _video = video;

    _tabBarOffset = 0;

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        showLiveFullscreenButton: false,
      ),
    );

    SheetCreationDialogViewModel viewModel =
        context.read<SheetCreationDialogViewModel>();
    viewModel.addOnCompleteCallback(onCompleteSettingSheetDetail);
    viewModel.addOnCancelCallback(onCancelCreatingSheet);

    await _loadSheets(video);

    _tabBarOffset = _findNotEmptyTabIndex();

    _isVideoIncludedInCollection.value = video.isInMyCollection;

    notifyListeners();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void onSelectSheet(BuildContext context, SheetInfo sheetInfo) async {
    _youtubePlayerController?.pause();

    bool isSuccessful = await _routeToPerformancePage(sheetInfo);

    if (isSuccessful) {
      return;
    }

    _routeName = "/loading-page";
    _routeArguments = {
      "video": video,
      "onCompleteLoading": () async {
        bool isSuccessful = await _routeToPerformancePage(sheetInfo);
        assert(isSuccessful);
      }
    };

    _shouldRoute = true;
    notifyListeners();
  }

  void onClickCollectionButton() {
    if (video == null) {
      log("E/BridgeViewModel: collection button clicked before init view model");
      return;
    }

    if (_isVideoIncludedInCollection.value) {
      _isVideoIncludedInCollection.value = false;
      CollectionRepository().deleteFromMyCollection(video!.id);
    } else {
      _isVideoIncludedInCollection.value = true;
      CollectionRepository().addToMyCollection(video!.id);
    }
  }

  void onLongClickSheet(BuildContext context, SheetInfo sheet) async {
    _sheetToDelete = sheet;

    String userId = (await _getUserId())!;

    if (userId == sheet.userId) {
      _isDeletingSheet.value = true;
    }
  }

  Future<void> onClickDeleteSheetButton() async {
    if (_sheetToDelete == null) {
      return;
    }

    _deleteSheet(_sheetToDelete!.id);
    _isDeletingSheet.value = false;
    _sheetToDelete = null;
    await _loadSheets(_video!);
    notifyListeners();
  }

  void onClickCancelDeletingButton() {
    _isDeletingSheet.value = false;
    _sheetToDelete = null;
  }

  void onClickCreateSheetButton(BuildContext context) {
    _isCreatingSheet.value = true;
  }

  void onCancelCreatingSheet() {
    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;
  }

  void onSelectSheetToDuplicate(SheetInfo sheetInfo) {
    _sheetToDuplicate = sheetInfo;
    _isSettingSheet.value = true;
  }

  Future<void> onCompleteSettingSheetDetail(String title) async {
    SheetInfo? sheetInfo = await _createSheet(
      sheetId: _sheetToDuplicate?.id ?? "",
      title: title,
    );

    if (sheetInfo != null) {
      bool isSuccessful = await _routeToPerformancePage(sheetInfo);
      assert(isSuccessful);
    } else {
      _routeName = "/loading-page";
      _routeArguments = {
        "video": video,
        "onCompleteLoading": () async {
          SheetInfo sheetInfo = (await _createSheet(
            sheetId: _sheetToDuplicate?.id ?? "",
            title: title,
          ))!;

          bool isSuccessful = await _routeToPerformancePage(sheetInfo);
          assert(isSuccessful);
        }
      };
      _shouldRoute = true;
    }

    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;
    _loadSheets(_video!);
  }

  void onCancelSettingSheetDetail() {
    _isCreatingSheet.value = false;
    _isSettingSheet.value = false;
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

  Future<bool> _routeToPerformancePage(SheetInfo sheetInfo) async {
    SheetData? sheetData = await _getSheetData(sheetInfo.id);

    if (sheetData == null) {
      return false;
    }

    _routeName = "/performance-page";
    _routeArguments = {
      "video": video,
      "sheetInfo": sheetInfo,
      "sheetData": sheetData,
    };
    _shouldRoute = true;

    notifyListeners();

    return true;
  }

  void onCompleteRoute() {
    _shouldRoute = false;
    _routeName = null;
    _routeArguments = null;
  }
}
