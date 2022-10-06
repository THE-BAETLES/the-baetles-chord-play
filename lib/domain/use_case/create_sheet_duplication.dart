import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/chord_block.dart';
import '../model/sheet_data.dart';
import '../model/sheet_info.dart';

class CreateSheetDuplication {
  final SheetRepository _sheetRepository;

  CreateSheetDuplication(this._sheetRepository);

  Future<SheetInfo?> call({
    required String sheetId,
    required String title,
  }) async {
    SheetInfo? sheetInfo =
        await _sheetRepository.createSheetDuplication(sheetId, title,);

    return sheetInfo;
  }
}
