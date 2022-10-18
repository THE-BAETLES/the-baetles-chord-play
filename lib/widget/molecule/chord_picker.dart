import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../controller/chord_picker_view_model.dart';
import '../../domain/model/chord.dart';
import '../../domain/model/note.dart';
import '../../domain/model/triad_type.dart';
import '../atom/app_colors.dart';

class ChordPicker extends StatelessWidget {
  late final ChordPickerViewModel viewModel;
  final Note? initRoot;
  final TriadType? initTriadType;

  ChordPicker({
    required Function(Chord?) onChangeChord,
    this.initRoot,
    this.initTriadType,
  }) {
    viewModel = ChordPickerViewModel(
      onChangeChord: onChangeChord,
      initRoot: initRoot,
      initTriadType: initTriadType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(builder: (context) {
        ChordPickerViewModel viewModel = context.watch<ChordPickerViewModel>();

        return Container(
          width: 270,
          height: 280,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (int value) {
                    log("${Note.pitchNames[value]}3");
                    viewModel.onChangeRoot(
                        Note.fromNoteName("${Note.pitchNames[value]}3"));
                  },
                  scrollController: FixedExtentScrollController(
                      initialItem: Note.pitchNames
                          .indexOf(initRoot?.flatNoteNameWithoutOctave ?? "C")),
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.transparentF4,
                    capStartEdge: false,
                    capEndEdge: false,
                  ),
                  children: Note.flatPitchNames
                      .map((e) => _pickerItem(
                          e,
                          viewModel.selectedNote?.flatNoteNameWithoutOctave ==
                              e))
                      .toList(),
                ),
              ),
              Expanded(
                child: Builder(builder: (context) {
                  final List<Widget> pickerItems = [];

                  TriadType.values.forEach((e) {
                    pickerItems.add(_pickerItem(
                        e.notation, viewModel.selectedTriadType == e));
                  });

                  return CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (int value) {
                      print(value);
                      viewModel.onChangeTriadType(TriadType.values[value]);
                    },
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: AppColors.transparentF4,
                      capStartEdge: false,
                      capEndEdge: false,
                    ),
                    children: pickerItems,
                  );
                }),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (int value) {
                    log("${Note.pitchNames[value]}3");
                    viewModel.onChangeRoot(
                      Note.fromNoteName("${Note.pitchNames[value]}3"),
                    );
                  },
                  scrollController: FixedExtentScrollController(
                    initialItem: Note.pitchNames
                        .indexOf(initRoot?.flatNoteNameWithoutOctave ?? "C"),
                  ),
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.transparentF4,
                    capStartEdge: false,
                    capEndEdge: false,
                  ),
                  children: Note.flatPitchNames
                      .map((e) => _pickerItem(e, viewModel.selectedNote?.flatNoteNameWithoutOctave == e))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _pickerItem(String item, bool isHighlighted) {
    return Container(
      child: Center(
        child: Text(
          item,
          style: isHighlighted
              ? const TextStyle(
                  color: AppColors.mainPointColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamilies.pretendard,
                  fontSize: 17,
                )
              : const TextStyle(
                  color: AppColors.gray73,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamilies.pretendard,
                  fontSize: 16,
                ),
        ),
      ),
    );
  }
}
