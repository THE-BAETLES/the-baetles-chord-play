import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';

import '../model/sheet_info.dart';

class GetLikedSheets {
  final SheetRepository _sheetRepository;

  GetLikedSheets(this._sheetRepository);

  Future<List<SheetInfo>> call() async {
    return await _sheetRepository.getLikedSheets();
  }
}