import 'package:the_baetles_chord_play/data/repository/sheet_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/patch_sheet_data.dart';

import '../model/chord.dart';
import '../model/chord_block.dart';
import '../model/sheet_data.dart';

class EditSheet {
  final PatchSheetData _patchSheetData;

  EditSheet(this._patchSheetData);

  Future<SheetData> call({
    required String sheetId,
    required SheetData sheet,
    required int position,
    required Chord? newChord,
  }) async {
    assert(position < sheet.chords.length);

    ChordBlock currentChordBlock = sheet.chords[position];
    ChordBlock newChordBlock = currentChordBlock.copy(chord: newChord);

    List<ChordBlock> newChords = List<ChordBlock>.of(sheet.chords);
    newChords[position] = newChordBlock;

    await _patchSheetData(
      sheetId: sheetId,
      position: position!,
      chord: newChordBlock.chord,
    );

    return sheet.copy(
      chords: newChords,
    );
  }
}
