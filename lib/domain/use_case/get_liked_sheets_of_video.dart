import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_info.dart';
import 'get_sheets_of_video.dart';

class GetLikedSheetsOfVideo {
  final GetSheetsOfVideo getSheetsOfVideo;
  final SheetRepository sheetRepository;

  GetLikedSheetsOfVideo(
    this.getSheetsOfVideo,
    this.sheetRepository,
  );

  Future<UnmodifiableListView<SheetInfo>> call(String userIdToken, String videoId) async {
    // TODO : source 연결

    // dummy data
    UnmodifiableListView<String> likedSheetsIds =
        UnmodifiableListView(['f3WgS5dummyFnyAl', 'safgeayFnyAl']);
    UnmodifiableListView<SheetInfo> sheets = await getSheetsOfVideo(videoId);

    // filtering
    List<SheetInfo> likedSheets =
        sheets.where((sheet) => likedSheetsIds.contains(sheet.id)).toList();

    return UnmodifiableListView<SheetInfo>(likedSheets);
  }
}
