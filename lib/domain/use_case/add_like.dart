import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

class AddLike {
  final SheetRepository _sheetRepository;

  AddLike(this._sheetRepository);

  Future<void> call(String sheetId) async {
    _sheetRepository.addLike(sheetId);
  }
}