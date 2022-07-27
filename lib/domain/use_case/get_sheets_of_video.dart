import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_music.dart';

class GetSheetsOfVideo {
  final SheetRepository sheetRepository;

  GetSheetsOfVideo(this.sheetRepository);

  Future<UnmodifiableListView<SheetMusic>> call(String videoId) async {
    return await sheetRepository.fetchSheetsByVideoId(videoId);
  }
}
