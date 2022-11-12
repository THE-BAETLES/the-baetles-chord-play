import 'package:flutter/material.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/domain/model/fingering_feedback.dart';
import 'package:the_baetles_chord_play/presentation/performance/fragment/message_view.dart';
import 'package:the_baetles_chord_play/presentation/performance/fragment/sheet_element_size.dart';
import 'package:the_baetles_chord_play/presentation/performance/control_bar.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_app_bar.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/presentation/performance/state/beat_state.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/molecule/EllipseToggleButton.dart';
import '../../widget/molecule/chord_picker.dart';
import 'fragment/guitar_tab_view.dart';
import 'fragment/sheet_auto_scroll_controller.dart';
import 'fragment/sheet_view.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage>
    with TickerProviderStateMixin {
  late PerformanceViewModel _performanceViewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initViewModel();
    });

    _performanceViewModel = context.read<PerformanceViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    PerformanceViewModel viewModel = context.read<PerformanceViewModel>();

    return Scaffold(
      backgroundColor: AppColors.grayF5,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
                valueListenable: viewModel.isTabVisible,
                builder: (context, value, _) {
                  return Row(
                    children: [
                      _sheetView(viewModel),
                      _tabView(viewModel),
                    ],
                  );
                }),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _appBar(viewModel),
          ),
          Positioned(
            bottom: 52,
            right: 0,
            height: 150,
            child: _messageView(viewModel),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _controlBar(viewModel),
          ),
          Positioned.fill(
            left: 0,
            top: 0,
            child: _loadingDialog(),
          ),
          Positioned.fill(
            left: 0,
            top: 0,
            child: _chordPicker(viewModel),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _performanceViewModel = context.read<PerformanceViewModel>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _performanceViewModel.reset();
    super.dispose();
  }

  void _initViewModel() {
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
  }

  Widget _sheetView(PerformanceViewModel viewModel) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: viewModel.beatStates,
        builder: (context, value, _) {
          return ValueListenableBuilder(
            valueListenable: viewModel.measureCount,
            builder: (context, value, _) {
              return ValueListenableBuilder(
                valueListenable: viewModel.sheetState,
                builder: (context, value, _) {
                  if (viewModel.sheetState.value?.sheetData == null) {
                    return Container();
                  }

                  return SafeArea(
                    child: LayoutBuilder(builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
                      final sheetElementSize = SheetElementSize.resize(
                        sheetHeight: constraints.maxHeight,
                        sheetWidth: constraints.maxWidth,
                        measureCount: viewModel.measureCount.value,
                        spaceWidth: 4,
                        barWidth: 2,
                      );

                      return SheetView(
                        currentPosition: viewModel.currentPosition.value,
                        sheetData: (viewModel.sheetState.value?.sheetData)!,
                        beatStates: viewModel.beatStates.value.states,
                        feedbackState: viewModel.feedbackState,
                        scrollController: _sheetAutoScrollController(
                          sheetElementSize: sheetElementSize,
                          viewModel: viewModel,
                        ),
                        onClick: (int tileIndex) {
                          viewModel.onTileClicked(tileIndex);
                        },
                        onLongClick: (tileIndex) {
                          viewModel.onTileLongClicked(tileIndex);
                        },
                        scaleAdapter: viewModel.scaleAdapter,
                        sheetElementSize: sheetElementSize,
                      );
                    }),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  ScrollController _sheetAutoScrollController({
    required SheetElementSize sheetElementSize,
    required PerformanceViewModel viewModel,
  }) {
    const int beatPerMeasure = 4;
    List<ValueNotifier<BeatState>> beatStates =
        viewModel.beatStates.value.states;

    return SheetAutoScrollController(
      playingPosition: viewModel.beatStates.value.playingPosition,
      topMargin: SheetView.topMargin,
      bottomMargin: SheetView.bottomMargin,
      lineHeight: sheetElementSize.tileHeight +
          SheetView.spaceBetweenRow +
          sheetElementSize.wordPadding * 2,
      screenHeight: MediaQuery.of(context).size.height,
      beatPerLine: viewModel.measureCount.value * 4,
      lineCount: (beatStates.length /
              (viewModel.measureCount.value * beatPerMeasure).toDouble())
          .ceil(),
    );
  }

  Widget _tabView(PerformanceViewModel viewModel) {
    return Builder(builder: (context) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );

      if (viewModel.isTabVisible.value) {
        controller.reverse(from: 1.0);
      } else {
        controller.animateTo(1.0);
      }

      return SlideTransition(
        transformHitTests: true,
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(1, 0),
        ).animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        child: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          return AnimatedContainer(
            color: Colors.white,
            duration: const Duration(milliseconds: 500),
            child: GuitarTabView(
              width: viewModel.isTabVisible.value ? 230 : 0,
              height: constraints.maxHeight,
            ),
          );
        }),
      );
    });
  }

  Widget _messageView(PerformanceViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.isPitchBeingChecked,
      builder: (context, value, _) {
        return ValueListenableBuilder(
          valueListenable: viewModel.feedbackState,
          builder: (context, value, _) {
            return ValueListenableBuilder(
                valueListenable: viewModel.beatStates.value.playingPosition,
                builder: (context, value, _) {
                  final feedbacks = viewModel.feedbackState.value.feedbacks;

                  FingeringFeedback? feedback;

                  if (!viewModel.isPitchBeingChecked.value) {
                    // 실시간 피드백이 꺼져 있으면 표시하지 않음
                    feedback = null;
                  } else if (viewModel.playOption.value.isPlaying) {
                    // 연주 중에는 마지막 피드백을 표시함.
                    if (feedbacks.isNotEmpty) {
                      feedback = feedbacks.last;
                    }
                  } else {
                    // 연주하지 않는 중에는 현재 위치의 피드백을 표시함.
                    int currentBeatPosition =
                        viewModel.beatStates.value.playingPosition.value;

                    try {
                      feedback = feedbacks.lastWhere(
                            (feedback) => feedback.beatIndex == currentBeatPosition,
                      );
                    } on StateError catch (e) {
                      // nothing
                    }
                  }

                  if (feedback == null) {
                    return const SizedBox(width: 0, height: 0);
                  }

                  return Container(
                    width: 330,
                    height: 300,
                    margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: AppColors.shadow94,
                            blurRadius: 3),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: feedback.answer.chord.fullNameWithoutOctave,
                            style: const TextStyle(fontSize: 18, color: AppColors.redFF),
                          ),
                          const TextSpan(
                            text: "의 ",
                            style: TextStyle(fontSize: 16, color: AppColors.black04),
                          ),
                          TextSpan(
                            text: _listToString(feedback.wrongStringNumbers),
                            style: const TextStyle(fontSize: 16, color: AppColors.redFF),
                          ),
                          const TextSpan(
                            text: "번 줄을 잘못 잡았어요.",
                            style: TextStyle(fontSize: 16, color: AppColors.black04),
                          ),
                        ]))),
                        Container(
                          width: 145,
                          height: 160,
                          child: FlutterGuitarTab(
                            tab: feedback.answer.positionString,
                            size: 7,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        );
      }
    );
  }

  Widget _appBar(PerformanceViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.playOption,
      builder: (context, value, _) {
        final AnimationController controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: this,
        );

        if (viewModel.playOption.value.isPlaying) {
          controller.animateTo(1.0);
        } else {
          controller.reverse(from: 1.0);
        }

        return SlideTransition(
          transformHitTests: true,
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0, -1),
          ).animate(CurvedAnimation(
            parent: controller,
            curve: Curves.ease,
          )),
          child: PerformanceAppBar(
            viewModel: viewModel,
            // height: !viewModel.playOption.value.isPlaying ? 52 : 0,
          ),
        );
      },
    );
  }

  Widget _controlBar(PerformanceViewModel viewModel) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: viewModel.currentPosition,
          builder: (context, value, _) {
            return LinearProgressIndicator(
              value: ((viewModel.currentPositionInPercentage ?? 0) / 100.0)
                  .clamp(0, 1),
              color: AppColors.mainPointColor,
              backgroundColor: Colors.transparent,
              minHeight: 3,
            );
          },
        ),
        const ControlBar(),
      ],
    );
  }

  Widget _loadingDialog() {
    return ValueListenableBuilder(
      valueListenable: _performanceViewModel.isLoading,
      builder: (context, value, _) {
        return SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _performanceViewModel.isLoading.value,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.mainPointColor.withAlpha(150),
                      ),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _chordPicker(PerformanceViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.editingPosition,
      builder: (context, value, _) {
        return Visibility(
          visible: viewModel.isEditing,
          child: GestureDetector(
            onTap: () {
              viewModel.editingPosition.value = null;
            },
            child: Container(
              color: AppColors.shadow00,
              alignment: Alignment.center,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 330,
                  height: 280,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 190,
                        child: ChordPicker(
                          onChangeChord: viewModel.onChangeChord,
                          initRoot: viewModel.editedChord?.root,
                          initTriadType: viewModel.editedChord?.triadType,
                          initBass: viewModel.editedChord?.bass,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 330,
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: EllipseToggleButton(
                                text: "취소",
                                initState: false,
                                onPressed: (_) => viewModel.onCancelEdit(),
                                textStyleOnActivated: const TextStyle(
                                  fontFamily: AppFontFamilies.pretendard,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textStyleOnInActivated: const TextStyle(
                                  fontFamily: AppFontFamilies.pretendard,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black04,
                                  fontSize: 14,
                                ),
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 1,
                              child: EllipseToggleButton(
                                text: "지우기",
                                initState: false,
                                onPressed: (_) =>
                                    viewModel.onRemoveChordButtonClicked(),
                                textStyleOnActivated: const TextStyle(
                                  fontFamily: AppFontFamilies.pretendard,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textStyleOnInActivated: const TextStyle(
                                  fontFamily: AppFontFamilies.pretendard,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black04,
                                  fontSize: 14,
                                ),
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 1,
                              child: EllipseToggleButton(
                                text: "확인",
                                initState: true,
                                onPressed: (_) => viewModel.onApplyEdit(),
                                textStyleOnActivated: const TextStyle(
                                  fontFamily: AppFontFamilies.pretendard,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textStyleOnInActivated: const TextStyle(
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _listToString(List<int> numbers) {
    final buffer = StringBuffer();

    for (int i = 0; i < numbers.length; ++i) {
      int number = numbers[i];
      buffer.write(number);

      if (i != numbers.length - 1) {
        buffer.write(", ");
      }
    }

    return buffer.toString();
  }
}
