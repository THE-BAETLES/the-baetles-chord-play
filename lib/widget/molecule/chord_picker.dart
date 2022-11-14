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
  final Note? initBass;

  ChordPicker({
    required Function(Chord?) onChangeChord,
    this.initRoot,
    this.initTriadType,
    this.initBass,
  }) {
    viewModel = ChordPickerViewModel(
      onChangeChord: onChangeChord,
      initRoot: initRoot,
      initTriadType: initTriadType,
      initBass: initBass,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(builder: (context) {
        ChordPickerViewModel viewModel = context.watch<ChordPickerViewModel>();

        return Container(
          width: 330,
          height: 280,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (int value) {
                    Note selectedRoot =
                        Note.fromNoteName("${Note.pitchNames[value]}3");
                    viewModel.onChangeRoot(selectedRoot);
                  },
                  scrollController: FixedExtentScrollController(
                      initialItem: Note.pitchNames
                          .indexOf(initRoot?.noteNameWithoutOctave ?? "C")),
                  selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.transparentF4,
                    capStartEdge: false,
                    capEndEdge: false,
                  ),
                  children: Note.pitchNames
                      .map((e) => _pickerItem(e, viewModel.selectedNote?.noteNameWithoutOctave == e))
                      .toList(),
                ),
              ),
              Expanded(
                child: Builder(builder: (context) {
                  final List<Widget> pickerItems = [];

                  for (var e in TriadType.values) {
                    pickerItems.add(_pickerItem(
                        e.notation, viewModel.selectedTriadType == e));
                  }

                  return CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (int value) {
                      viewModel.onChangeTriadType(TriadType.values[value]);
                    },
                    scrollController: FixedExtentScrollController(
                        initialItem: TriadType.values
                            .map((e) => e.notation)
                            .toList()
                            .indexOf(initTriadType?.notation ??
                                TriadType.none.notation)),
                    selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
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
                  onSelectedItemChanged: (int index) {
                    Note? selectedBass;

                    if (index > 0) {
                      selectedBass =
                          Note.fromNoteName("${Note.pitchNames[index - 1]}3");
                    }

                    viewModel.onChangeBass(selectedBass);
                  },
                  scrollController: FixedExtentScrollController(
                    initialItem: Note.pitchNames
                        .indexOf(initBass?.noteNameWithoutOctave ?? "C"),
                  ),
                  selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.transparentF4,
                    capStartEdge: false,
                    capEndEdge: false,
                  ),
                  children: Note.pitchNames
                      .map((e) => _pickerItem("on ${e}", viewModel.selectedBass?.noteNameWithoutOctave == e))
                      .toList()
                    ..insert(
                        0, _pickerItem("none", viewModel.selectedBass == null)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _pickerItem(String item, bool isHighlighted) {
    return Center(
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
    );
  }
}
