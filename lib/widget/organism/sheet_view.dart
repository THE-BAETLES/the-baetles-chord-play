import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:the_baetles_chord_play/widget/molecule/beat_tile.dart';
import 'package:the_baetles_chord_play/widget/atom/marker_stick.dart';

import '../../domain/model/sheet_data.dart';

class SheetView extends StatelessWidget {
  static const int beatPerWord = 4;
  static const int wordPerRow = 4;
  static const int beatPerRow = beatPerWord * wordPerRow;

  final SheetData sheetData;
  final int currentPosition;

  final Function(int)? onClick;
  final Function(int)? onLongClick;

  const SheetView({
    Key? key,
    required this.sheetData,
    required this.currentPosition,
    this.onClick,
    this.onLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bps = sheetData.bpm / 60.0;

    final List<Widget> tileRows = [];

    int highlightedTileIndex = (bps * currentPosition / 1000).toInt();
    int currentBlockIndex = 0;
    int rowCount = sheetData.chords.length > 0
        ? (sheetData.chords.last.position / beatPerRow).toInt() + 1
        : 0;

    for (int rowIndex = 0; rowIndex < rowCount; ++rowIndex) {
      final List<Widget> rowChildren = [];

      for (int tileIndex = 0; tileIndex < beatPerRow; ++tileIndex) {
        if (tileIndex % (beatPerWord) == 0) {
          // 마디의 시작 부분
          // TODO : 마커에 색 추가
          rowChildren.add(MarkerStick());
        }

        int tileIndexOfSheet = rowIndex * beatPerRow + tileIndex;

        if (currentBlockIndex < sheetData.chords.length &&
            tileIndexOfSheet == sheetData.chords[currentBlockIndex].position) {
          rowChildren.add(BeatTile(
            chord: sheetData.chords[currentBlockIndex].chord,
            isHighlighted: highlightedTileIndex == tileIndexOfSheet,
            onClick: () {
              this.onClick?.call(tileIndexOfSheet);
            },
            onLongClick: () {
              this.onLongClick?.call(tileIndexOfSheet);
            },
          ));
          currentBlockIndex++;
        } else {
          rowChildren.add(BeatTile(
            isHighlighted: highlightedTileIndex == tileIndexOfSheet,
            onClick: () {
              this.onClick?.call(tileIndexOfSheet);
            },
            onLongClick: () {
              this.onLongClick?.call(tileIndexOfSheet);
            },
          ));
        }
      }

      tileRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: rowChildren,
      ));

      tileRows.add(Container(
        height: 20,
      ));
    }

    return Container(
      child: ListView(
        children: tileRows,
      ),
    );
  }
}
