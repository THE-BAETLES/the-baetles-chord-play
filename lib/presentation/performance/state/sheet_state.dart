import '../../../domain/model/sheet_data.dart';
import '../../../domain/model/sheet_info.dart';

class SheetState {
  final SheetInfo sheetInfo;
  final SheetData sheetData;

  SheetState({
    required this.sheetInfo,
    required this.sheetData,
  });

  SheetState copy({
    SheetInfo? sheetInfo,
    SheetData? sheetData,
  }) {
    return SheetState(
      sheetInfo: sheetInfo ?? this.sheetInfo,
      sheetData: sheetData ?? this.sheetData,
    );
  }
}
