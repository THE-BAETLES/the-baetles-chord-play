import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_music.dart';
import 'get_sheets_of_video.dart';

class GetLikedSheetsOfVideo {
  final GetSheetsOfVideo getSheetsOfVideo;
  final SheetRepository sheetRepository;

  GetLikedSheetsOfVideo(
    this.getSheetsOfVideo,
    this.sheetRepository,
  );

  Future<UnmodifiableListView<SheetMusic>> call(
      String idToken, String videoId) async {
    // TODO : source 연결

    // dummy data
    UnmodifiableListView<String> likedSheetsIds =
        UnmodifiableListView(['f3WgS5dummyFnyAl', 'safgeayFnyAl']);
    UnmodifiableListView<SheetMusic> sheetsOfVideo =
        await getSheetsOfVideo(videoId);

    List<SheetMusic> likedSheets =
        sheetsOfVideo.where((e) => likedSheetsIds.contains(e.id)).toList();

    return UnmodifiableListView<SheetMusic>(likedSheets);
  }
}
