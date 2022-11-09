import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/performance/state/feedback_state.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/beat_tile.dart';
import 'package:the_baetles_chord_play/widget/atom/marker_stick.dart';

import '../../../domain/model/chord_block.dart';
import '../../../domain/model/sheet_data.dart';
import '../state/beat_state.dart';
import 'sheet_element_size.dart';
import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/chord_text.dart';
import '../adapter/scale_adapter.dart';

class SheetView extends StatelessWidget {
  static const int beatPerMeasure = 4;
  static const double topMargin = 62.0;
  static const double bottomMargin = 105.0;
  static const double spaceBetweenRow = 20.0;

  final SheetData sheetData;
  final int currentPosition;
  final SheetElementSize sheetElementSize;
  final ScrollController? scrollController;
  final List<ValueNotifier<BeatState>> beatStates;
  final ValueNotifier<FeedbackState> feedbackState;

  final Function(int)? onClick;
  final Function(int)? onLongClick;
  final ScaleAdapter? scaleAdapter;

  const SheetView({
    Key? key,
    required this.sheetData,
    required this.currentPosition,
    required this.feedbackState,
    required this.sheetElementSize,
    required this.beatStates,
    this.scrollController,
    this.onClick,
    this.onLongClick,
    this.scaleAdapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bps = sheetData.bpm / 60.0;

    final List<Widget> tileRows = [];

    int highlightedTileIndex = bps * currentPosition ~/ 1000;

    int beatPerRow = (beatPerMeasure * sheetElementSize.measureCount);

    int rowCount = sheetData.chords.isNotEmpty
        ? _calcRowCount(sheetData.chords.length, beatPerRow)
        : 0;

    for (int rowIndex = 0; rowIndex < rowCount; ++rowIndex) {
      tileRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _tileRow(
            beatPerMeasure,
            (beatPerMeasure * sheetElementSize.measureCount),
            rowIndex,
            highlightedTileIndex,
            // currentChordIndex,
            beatStates,
          ),
        ),
      );

      // vertical divider
      tileRows.add(Container(
        height: spaceBetweenRow,
      ));
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleStart: scaleAdapter?.onScaleStart,
      onScaleUpdate: scaleAdapter?.onScaleUpdate,
      onScaleEnd: scaleAdapter?.onScaleEnd,
      child: SizedBox(
        width: sheetElementSize.sheetWidth,
        height: sheetElementSize.sheetHeight,
        child: Scrollbar(
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: topMargin),
              ...tileRows,
              const SizedBox(height: bottomMargin),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _tileRow(
    int beatPerWord,
    int beatPerRow,
    int rowIndex,
    int highlightedTileIndex,
    List<ValueNotifier<BeatState>> beatStates,
  ) {
    final List<Widget> rowChildren = [];
    rowChildren.add(
      Container(
        width: sheetElementSize.spaceWidth,
      ),
    );

    for (int tileIndex = 0; tileIndex < beatPerRow; ++tileIndex) {
      if (tileIndex % (beatPerWord) == 0) {
        // 마디의 시작 부분
        // TODO : 마커에 색 추가
        rowChildren.add(MarkerStick(
          width: sheetElementSize.barWidth,
          height: sheetElementSize.barHeight,
        ));

        rowChildren.add(
          Container(
            width: sheetElementSize.spaceWidth,
          ),
        );
      }

      int tileIndexOfSheet = _calcTileIndex(rowIndex, beatPerRow, tileIndex);

      late ValueNotifier<BeatState> beatState;

      if (tileIndexOfSheet < beatStates.length) {
        beatState = beatStates[tileIndexOfSheet];
      } else {
        beatState = ValueNotifier(
          BeatState(
            null,
            false,
          ),
        );
      }

      // bool hasChord = currentChordIndex < sheetData.chords.length &&
      //     tileIndexOfSheet == sheetData.chords[currentChordIndex].position;

      rowChildren.add(
        ValueListenableBuilder(
          valueListenable: beatState,
          builder: (context, value, _) {
            return ValueListenableBuilder(
              valueListenable: feedbackState,
              builder: (context, value, _) {
                // present correct and incorrect
                Color borderColor = Colors.transparent;
                Color textColor = AppColors.black04;

                if (feedbackState.value.correctIndexes.contains(tileIndexOfSheet)) {
                  borderColor = AppColors.blue71;
                  textColor = AppColors.blue71;
                } else if (feedbackState.value.wrongIndexes.contains(tileIndexOfSheet)) {
                  borderColor = AppColors.redFF;
                  textColor = AppColors.redFF;
                }

                if (beatState.value.isPlaying) {
                  textColor = Colors.white;
                }

                return BeatTile(
                  height: sheetElementSize.tileHeight,
                  width: sheetElementSize.tileWidth,
                  isHighlighted: beatState.value.isPlaying,
                  borderColor: borderColor,
                  onClick: () {
                    onClick?.call(tileIndexOfSheet);
                  },
                  onLongClick: () {
                    onLongClick?.call(tileIndexOfSheet);
                  },
                  child: beatState.value.chord != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChordText(
                              root: beatState.value.chord!.root
                                  .flatNoteNameWithoutOctaveAndKeySignature,
                              keySignature:
                                  beatState.value.chord!.root.keySignature,
                              postfix:
                                  beatState.value.chord!.triadType.shortNotation,
                              rootSize: sheetElementSize.chordRootTextSize,
                              postfixSize: sheetElementSize.chordPostfixTextSize,
                              rootColor: textColor,
                              postfixColor: textColor,
                            ),
                            beatState.value.chord!.bass != null
                                ? Container(
                                    width: sheetElementSize.tileWidth / 1.5,
                                    height: sheetElementSize.tileHeight / 4.5,
                                    margin: EdgeInsets.only(
                                        top: sheetElementSize.tileHeight / 200),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.grayC3,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "on ${beatState.value.chord!.bass!.flatNoteNameWithoutOctave}",
                                      style: TextStyle(
                                        fontSize:
                                            sheetElementSize.chordPostfixTextSize *
                                                0.75,
                                        fontFamily: AppFontFamilies.pretendard,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteF8,
                                        height: 1.1,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : null,
                );
              },
            );
          }
        ),
      );

      rowChildren.add(
        Container(
          width: sheetElementSize.spaceWidth,
        ),
      );

      // while (currentChordIndex < sheetData.chords.length &&
      //     tileIndexOfSheet == sheetData.chords[currentChordIndex].position) {
      //   // 같은 포지션에 코드가 두 개 이상 있으면 두번째부터 무시함.
      //   currentChordIndex++;
      // }
    }

    return rowChildren;
  }

  int _calcTileIndex(int rowIndex, int beatPerRow, int tileIndex) {
    return rowIndex * beatPerRow + tileIndex;
  }

  int _calcRowCount(int beatCount, int beatPerRow) {
    int rowCount = beatCount ~/ beatPerRow;

    if (beatCount % beatPerRow > 0) {
      rowCount += 1;
    }

    return rowCount;
  }
}
