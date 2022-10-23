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
    required Chord newChord,
  }) async {

    double spb = 1 / (sheet.bpm / 60.0);
    ChordBlock newChordBlock = ChordBlock(
      newChord,
      position,
      position * spb,
      (position + 1) * spb,
    );

    List<ChordBlock> newChords = List<ChordBlock>.of(sheet.chords);
    int? index = newChords.indexWhere((chord) => chord.position >= position);

    if (index == -1) {
      newChords.add(newChordBlock);
    } else if (newChords[index].position == position) {
      newChords[index] = newChordBlock;
    } else {
      newChords.insert(index, newChordBlock);
    }

    await _patchSheetData(
      sheetId: sheetId,
      position: position!,
      chord: newChordBlock.chord.fullNameWithoutOctave,
    );

    return sheet.copy(
      chords: newChords,
    );
  }
}
