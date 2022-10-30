import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_by_id.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_like.dart';
import '../../domain/use_case/delete_like.dart';
import '../../domain/use_case/get_liked_sheets.dart';
import '../../domain/use_case/get_my_sheets.dart';
import '../../domain/use_case/get_sheet_data.dart';

class SheetViewModel with ChangeNotifier {
  final GetMySheets _getMySheets;
  final GetLikedSheets _getLikedSheets;
  final GetVideoById _getVideoById;
  final GetSheetData _getSheetData;
  final AddLike _addLike;
  final DeleteLike _deleteLike;

  List<SheetInfo>? _mySheets = [];
  List<SheetInfo>? _likedSheets = [];
  List<Video?>? _videosOfMySheets = [];
  List<Video?>? _videosOfLikedSheets = [];

  bool _shouldRoute = false;
  String? _routeName;
  Object? _routeArguments;

  List<SheetInfo>? get mySheets => _mySheets;

  List<SheetInfo>? get likedSheets => _likedSheets;

  List<Video?>? get videosOfMySheets => _videosOfMySheets;

  List<Video?>? get videosOfLikedSheets => _videosOfLikedSheets;

  bool get shouldRoute => _shouldRoute;

  String? get routeName => _routeName;

  Object? get routeArguments => _routeArguments;

  SheetViewModel(
    this._getMySheets,
    this._getLikedSheets,
    this._getVideoById,
    this._getSheetData,
    this._addLike,
    this._deleteLike,
  ) {
    _loadSheets();
  }

  Future<void> onClickLikeButton(SheetInfo sheet) async {
    bool newLikeState = !sheet.liked;

    if (newLikeState) {
      await _addLike(sheet.id);
    } else {
      await _deleteLike(sheet.id);
    }

    await _loadSheets();

    notifyListeners();
  }

  Future<void> onClickSheetItem(SheetInfo sheetInfo) async {
    Video? video = await _getVideoById(sheetInfo.videoId);
    SheetData? sheetData = await _getSheetData(sheetInfo.id);

    if (video == null) {
      log(
        "cannot load video for oute",
        name: "SheetViewModel.onClickSheetItem",
      );
      return;
    } else if (sheetData == null) {
      _routeToLoadingPage(
          video: video,
          onCompleteLoading: () async {
            SheetData sheetData = (await _getSheetData(sheetInfo.id))!;
            bool isSuccessful = await _routeToPerformancePage(
              video: video,
              sheetInfo: sheetInfo,
              sheetData: sheetData,
            );
            assert(isSuccessful);
          });
    } else {
      bool isSuccessful = await _routeToPerformancePage(
        video: video,
        sheetInfo: sheetInfo,
        sheetData: sheetData,
      );
    }
  }

  void onCompleteRoute() {
    _shouldRoute = false;
    _routeName = null;
    _routeArguments = null;
  }

  Future<void> _loadSheets() async {
    Future<List<SheetInfo>> mySheetsResponse = _getMySheets();
    Future<List<SheetInfo>> likedSheetsResponse = _getLikedSheets();

    _mySheets = await mySheetsResponse;
    _likedSheets = await likedSheetsResponse;

    _videosOfMySheets = await _getVideosOfSheets(_mySheets!);
    _videosOfLikedSheets = await _getVideosOfSheets(_likedSheets!);

    notifyListeners();
  }

  Future<List<Video?>> _getVideosOfSheets(List<SheetInfo> sheets) async {
    final List<Future<Video?>> videoResponses = [];
    final List<Video?> result = [];

    for (SheetInfo sheet in sheets) {
      videoResponses.add(_getVideoById(sheet.videoId));
    }

    for (Future<Video?> response in videoResponses) {
      result.add(await response);
    }

    return result;
  }

  Future<bool> _routeToPerformancePage({
    required Video video,
    required SheetInfo sheetInfo,
    required SheetData sheetData,
  }) async {
    _routeName = "/performance-page";
    _routeArguments = {
      "video": video,
      "sheetInfo": sheetInfo,
      "sheetData": sheetData,
    };
    _shouldRoute = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    return true;
  }

  void _routeToLoadingPage({
    required Video video,
    required Function() onCompleteLoading,
  }) {
    _routeName = "/loading-page";
    _routeArguments = {
      "video": video,
      "onCompleteLoading": onCompleteLoading,
    };

    _shouldRoute = true;
    notifyListeners();
  }
}
