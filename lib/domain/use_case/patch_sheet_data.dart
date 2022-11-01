import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/chord.dart';

class PatchSheetData {
  final SheetRepository _sheetRepository;

  PatchSheetData(this._sheetRepository);

  Future<bool> call({
    required String sheetId,
    required int position,
    required Chord? chord,
  }) async {
    return await _sheetRepository.patchSheet(
      sheetId,
      position,
      chord,
    );
  }
}
