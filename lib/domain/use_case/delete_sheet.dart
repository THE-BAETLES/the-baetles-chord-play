import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

class DeleteSheet {
  SheetRepository _sheetRepository;

  DeleteSheet(this._sheetRepository);

  Future<bool> call(String sheetId) async {
    return await _sheetRepository.deleteSheet(sheetId);
  }
}