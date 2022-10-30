import '../../data/repository/sheet_repository.dart';
import '../model/sheet_info.dart';

class GetMySheets {
  final SheetRepository _sheetRepository;

  GetMySheets(this._sheetRepository);

  Future<List<SheetInfo>> call() async {
    return await _sheetRepository.getMySheets();
  }
}