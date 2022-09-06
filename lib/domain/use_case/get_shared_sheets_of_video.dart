import 'package:the_baetles_chord_play/domain/model/sheet_info.dart';

import 'get_sheets_of_video.dart';

class GetSharedSheetsOfVideo {
  GetSheetsOfVideo _getSheetsOfVideo;

  GetSharedSheetsOfVideo(this._getSheetsOfVideo);

  Future<List<SheetInfo>> call(String videoId) async {
    return (await _getSheetsOfVideo(videoId))['shared'] ?? [];
  }
}