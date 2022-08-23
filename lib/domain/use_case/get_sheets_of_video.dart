import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_info.dart';

class GetSheetsOfVideo {
  final SheetRepository _sheetRepository;

  GetSheetsOfVideo(this._sheetRepository);

  Future<Map<String, List<SheetInfo>>> call(String videoId) async {
    return await _sheetRepository.fetchSheetsByVideoId(videoId);
  }
}
