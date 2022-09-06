import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/chord_block.dart';
import '../model/sheet_data.dart';
import '../model/sheet_info.dart';

class CreateSheet {
  final SheetRepository _sheetRepository;

  CreateSheet(this._sheetRepository);

  Future<SheetInfo?> call({
    required String videoId,
    required String title,
    required double bpm,
    required List<ChordBlock> chords,
  }) async {
    SheetInfo? sheetInfo =
        await _sheetRepository.createSheetInfo(videoId, title);

    if (sheetInfo == null) {
      return null;
    }

    String? sheetId = await _sheetRepository.createSheetData(
      videoId,
      title,
      SheetData(id: sheetInfo.id, bpm: bpm, chords: chords),
    );

    if (sheetId == null) {
      return null;
    }

    return sheetInfo;
  }
}
