import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

class DeleteLike {
  final SheetRepository _sheetRepository;

  DeleteLike(this._sheetRepository);

  Future<void> call(String sheetId) async {
    await _sheetRepository.deleteLike(sheetId);
  }
}