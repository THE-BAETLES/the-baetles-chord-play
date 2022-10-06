import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/chord_block.dart';
import '../model/sheet_data.dart';
import '../model/sheet_info.dart';

class CreateSheetDuplication {
  final SheetRepository _sheetRepository;

  CreateSheetDuplication(this._sheetRepository);

  Future<bool> call({
    required String sheetId,
    required String title,
  }) async {
    return await _sheetRepository.createSheetDuplication(sheetId, title,);
  }
}
