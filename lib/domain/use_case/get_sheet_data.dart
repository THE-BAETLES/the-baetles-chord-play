import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_data.dart';

class GetSheetData {
  SheetRepository _sheetRepository;

  GetSheetData(this._sheetRepository);

  Future<SheetData?> call(String sheetId) async {
    return _sheetRepository.fetchSheetDataBySheetId(sheetId);
  }
}