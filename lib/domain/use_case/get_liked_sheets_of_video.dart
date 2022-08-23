import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_info.dart';
import 'get_sheets_of_video.dart';

class GetLikedSheetsOfVideo {
  final GetSheetsOfVideo getSheetsOfVideo;

  GetLikedSheetsOfVideo(
    this.getSheetsOfVideo,
  );

  Future<List<SheetInfo>> call(String videoId) async {
    List<SheetInfo> likedSheets = (await getSheetsOfVideo(videoId))['like'] ?? [];
    return likedSheets;
  }
}
