import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';
import 'package:the_baetles_chord_play/presentation/performance/control_bar.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/molecule/EllipseToggleButton.dart';
import '../../widget/organism/sheet_view.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {

  late PerformanceViewModel _performanceViewModel;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      Video video = arguments['video'] as Video;
      SheetInfo sheetInfo = arguments["sheetInfo"] as SheetInfo;
      SheetData sheetData = arguments['sheetData'] as SheetData;

      PerformanceViewModel viewModel = context.read<PerformanceViewModel>();

      viewModel.initViewModel(
        video: video,
        sheetInfo: sheetInfo,
        sheetData: sheetData,
      );
    });

    _performanceViewModel = context.read<PerformanceViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    PerformanceViewModel viewModel = context.read<PerformanceViewModel>();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        toolbarHeight: 52,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: AppColors.black04,
        ),
        elevation: 0,
        title: Text(
          viewModel.sheetState?.sheetInfo.title ?? "",
          style: TextStyle(
            color: AppColors.black04,
            fontFamily: AppFontFamilies.notosanskr,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Container(
            width: 22,
            height: 20.52,
            child: SvgPicture.asset(
              "assets/icons/ic_empty_heart.svg",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 16,
          ),
          Container(
            width: 28,
            height: 29,
            child: SvgPicture.asset(
              "assets/icons/ic_expansion.svg",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 16,
          ),
        ],
      ),
      backgroundColor: AppColors.grayF5,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 130,
              width: MediaQuery.of(context).size.width,
              child: ValueListenableBuilder(
                valueListenable: viewModel.currentPosition,
                builder: (context, value, _) {
                  return SheetView(
                    currentPosition: viewModel.currentPosition.value,
                    sheetData: (viewModel.sheetState?.sheetData)!,
                    correctIndexes: viewModel.correctIndexes.toList(),
                    wrongIndexes: viewModel.wrongIndexes.toList(),
                    onClick: (int tileIndex) {
                      viewModel.onTileClick(tileIndex);
                    },
                    onLongClick: (tileIndex) {
                      viewModel.onTileLongClick(tileIndex);
                    },
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ControlBar(),
          ),
          Visibility(
            visible: viewModel.isEditing,
            child: Positioned(
              left: 0,
              top: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _chordRow(
                          Note((viewModel.editingRoot?.keyNumber ?? 12) - 1),
                          viewModel),
                      _chordRow(viewModel.editingRoot, viewModel),
                      _chordRow(
                          Note((viewModel.editingRoot?.keyNumber ?? 12) + 1),
                          viewModel),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chordRow(Note? note, PerformanceViewModel viewModel) {
    return Container(
      width: 300,
      height: 44,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: EllipseToggleButton(
              text: "${note?.noteNameWithoutOctave} minor",
              initState: false,
              onPressed: (_) => viewModel.onApplyEdit(
                Chord(
                  note!,
                  TriadType.minor,
                ),
              ),
              textStyleOnActivated: TextStyle(
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 14,
              ),
              textStyleOnInActivated: TextStyle(
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
                color: AppColors.black04,
                fontSize: 14,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: EllipseToggleButton(
              text: "${note?.noteNameWithoutOctave} major",
              initState: false,
              onPressed: (_) => viewModel.onApplyEdit(
                Chord(
                  note!,
                  TriadType.major,
                ),
              ),
              textStyleOnActivated: TextStyle(
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 14,
              ),
              textStyleOnInActivated: TextStyle(
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
                color: AppColors.black04,
                fontSize: 14,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _performanceViewModel = context.read<PerformanceViewModel>();
  }

  @override
  void dispose() {
    _performanceViewModel.reset();
    super.dispose();
  }
}
