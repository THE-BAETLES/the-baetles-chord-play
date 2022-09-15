import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_baetles_chord_play/widget/molecule/beat_tile.dart';
import 'package:the_baetles_chord_play/widget/atom/marker_stick.dart';

import '../../../domain/model/sheet_data.dart';
import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/chord_text.dart';

class SheetView extends StatelessWidget {
  static const int beatPerWord = 4;
  static const int wordPerRow = 4;
  static const int beatPerRow = beatPerWord * wordPerRow;
  static const double topMargin = 10.0;
  static const double bottomMargin = 105.0;

  final SheetData sheetData;
  final List<int> correctIndexes;
  final List<int> wrongIndexes;
  final int currentPosition;

  final Function(int)? onClick;
  final Function(int)? onLongClick;

  const SheetView({
    Key? key,
    required this.sheetData,
    required this.currentPosition,
    required this.correctIndexes,
    required this.wrongIndexes,
    this.onClick,
    this.onLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bps = sheetData.bpm / 60.0;

    final List<Widget> tileRows = [];

    int highlightedTileIndex = bps * currentPosition ~/ 1000;
    int currentChordIndex = 0;
    int rowCount = sheetData.chords.isNotEmpty
        ? sheetData.chords.last.position ~/ beatPerRow + 1
        : 0;

    for (int rowIndex = 0; rowIndex < rowCount; ++rowIndex) {
      tileRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tileRow(
            beatPerWord,
            beatPerRow,
            rowIndex,
            highlightedTileIndex,
            currentChordIndex,
            sheetData,
          ),
        ),
      );

      // vertical spacer
      tileRows.add(Container(
        height: 20,
      ));

      while (currentChordIndex < sheetData.chords.length &&
          _calcTileIndex(rowIndex + 1, beatPerRow, 0) > sheetData.chords[currentChordIndex].position) {
        currentChordIndex++;
      }
    }

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: topMargin),
         ...tileRows,
          SizedBox(height: bottomMargin),
        ]
      ),
    );
  }

  List<Widget> _tileRow(
    int beatPerWord,
    int beatPerRow,
    int rowIndex,
    int highlightedTileIndex,
    int startChordIndex,
    SheetData sheetData,
  ) {
    final List<Widget> rowChildren = [];
    int currentChordIndex = startChordIndex;

    for (int tileIndex = 0; tileIndex < beatPerRow; ++tileIndex) {
      if (tileIndex % (beatPerWord) == 0) {
        // 마디의 시작 부분
        // TODO : 마커에 색 추가
        rowChildren.add(const MarkerStick());
      }

      int tileIndexOfSheet = _calcTileIndex(rowIndex, beatPerRow, tileIndex);

      Color borderColor = Colors.transparent;
      Color textColor = AppColors.black04;

      if (correctIndexes.contains(tileIndexOfSheet)) {
        borderColor = AppColors.blue71;
        textColor = AppColors.blue71;
      } else if (wrongIndexes.contains(tileIndexOfSheet)) {
        borderColor = AppColors.redFF;
        textColor = AppColors.redFF;
      }

      if (highlightedTileIndex == tileIndexOfSheet) {
        textColor = Colors.white;
      }

      bool hasChord = currentChordIndex < sheetData.chords.length &&
          tileIndexOfSheet == sheetData.chords[currentChordIndex].position;

      rowChildren.add(BeatTile(
        height: 40.0,
        width: 40.0,
        child: hasChord
            ? ChordText(
                root: sheetData
                    .chords[currentChordIndex].chord.root.noteNameWithoutOctave,
                postfix: sheetData
                    .chords[currentChordIndex].chord.triadType.shortNotation,
                rootColor: textColor,
                postfixColor: textColor,
              )
            : null,
        isHighlighted: highlightedTileIndex == tileIndexOfSheet,
        borderColor: borderColor,
        onClick: () {
          onClick?.call(tileIndexOfSheet);
        },
        onLongClick: () {
          onLongClick?.call(tileIndexOfSheet);
        },
      ));

      while (currentChordIndex < sheetData.chords.length &&
          tileIndexOfSheet == sheetData.chords[currentChordIndex].position) {
        // 같은 포지션에 코드가 두 개 이상 있으면 두번째부터 무시함.
        currentChordIndex++;
      }
    }

    return rowChildren;
  }

  int _calcTileIndex(int rowIndex, int beatPerRow, int tileIndex) {
    return rowIndex * beatPerRow + tileIndex;
  }
}
