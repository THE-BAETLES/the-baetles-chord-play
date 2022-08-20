import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';

import '../model/sheet_info.dart';

class GetMySheetsOfVideo {
  final GetSheetsOfVideo getSheetsOfVideo;

  GetMySheetsOfVideo(this.getSheetsOfVideo);

  Future<List<SheetInfo>> call(String videoId) async {
    List<SheetInfo> mySheets = (await getSheetsOfVideo(videoId))['my'] ?? [];
    return UnmodifiableListView<SheetInfo>(mySheets);
  }
}
