import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/toggle_button.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/molecule/EllipseToggleButton.dart';
import '../../widget/organism/sheet_view.dart';
import 'component/svg_toggle_button.dart';
import 'component/transposition_button.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  late Video video;
  late SheetInfo sheetInfo;
  late SheetData sheetData;
  late PerformanceViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    // 가로 방향으로 고정함
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      video = arguments['video'] as Video;
      sheetInfo = arguments["sheetInfo"] as SheetInfo;
      sheetData = arguments['sheetData'] as SheetData;

      PerformanceViewModel viewModel = context.read<PerformanceViewModel>();

      viewModel.initViewModel(
        video: video,
        sheetInfo: sheetInfo,
        sheetData: sheetData,
      );

      _viewModel = viewModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    PerformanceViewModel viewModel = context.watch<PerformanceViewModel>();

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
          sheetInfo.title,
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
              child: SheetView(
                currentPosition: viewModel.playState.currentPosition,
                sheetData: (viewModel.sheetState?.sheetData)!,
                correctIndexes: viewModel.correctIndexes.toList(),
                wrongIndexes: viewModel.wrongIndexes.toList(),
                onClick: (int tileIndex) {
                  viewModel.onTileClick(tileIndex);
                },
                onLongClick: (tileIndex) {
                  viewModel.onTileLongClick(tileIndex);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _controlBar(
              context,
              viewModel.play,
              viewModel.stop,
              viewModel.moveCurrentPosition,
              context.read<PerformanceViewModel>().playState,
              viewModel.youtubePlayerController,
              viewModel,
            ),
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

  Widget _controlBar(
      BuildContext context,
      void Function() play,
      void Function() stop,
      void Function(int) move,
      PlayState playState,
      final YoutubePlayerController? controller,
      final PerformanceViewModel viewModel) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width,
      color: AppColors.gray34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 13),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgToggleButton(
                    isToggled: viewModel.isMuted,
                    iconPath: 'assets/icons/ic_mute.svg',
                    text: 'Mute',
                    onClick: viewModel.onMuteButtonClicked,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgToggleButton(
                    isToggled: false,
                    iconPath: 'assets/icons/ic_repeat.svg',
                    text: 'Repeat',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ToggleButton(
                    isToggled: false,
                    text: "tempo",
                    icon: Text(
                      "X 1.0",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFontFamilies.montserrat,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TranspositionButton(),
                ),
              ],
            ),
          ),
          _controlButtons(context, play, stop, move, playState),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    width: 62,
                    height: 44,
                    color: Colors.black,
                    child: controller == null
                        ? null
                        : YoutubeVideoPlayer(controller: controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgToggleButton(
                    isToggled: viewModel.isPitchBeingChecked,
                    iconPath: 'assets/icons/ic_check2.svg',
                    text: 'Check On',
                    onClick: viewModel.onCheckButtonClicked,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SvgToggleButton(
                    isToggled: false,
                    iconPath: 'assets/icons/ic_record2.svg',
                    text: 'Rec.',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 13),
        ],
      ),
    );
  }

  Widget _controlButtons(BuildContext context, void Function() play,
      void Function() stop, void Function(int) move, PlayState playState) {
    return Container(
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              double secondPerBeat = 1 / (playState.defaultBpm / 60.0);
              int changeAmount = (8 * secondPerBeat * 1000).toInt();
              move(-changeAmount);
            },
            child: SvgPicture.asset("assets/icons/ic_prev_2.svg",
                width: 26, height: 30),
          ),
          GestureDetector(
            onTap: () {
              if (playState.isPlaying) {
                stop();
              } else {
                play();
              }
            },
            child: playState.isPlaying
                ? SvgPicture.asset("assets/icons/ic_pause.svg",
                    width: 22, height: 22)
                : SvgPicture.asset("assets/icons/ic_play2.svg",
                    width: 22, height: 22),
          ),
          GestureDetector(
            onTap: () {
              double secondPerBeat = 1 / (playState.defaultBpm / 60.0);
              int changeAmount = (8 * secondPerBeat * 1000).toInt();
              move(changeAmount);
            },
            child: SvgPicture.asset("assets/icons/ic_next_2.svg",
                width: 26, height: 30),
          )
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
    super.didChangeDependencies();
    _viewModel = context.read<PerformanceViewModel>();
  }

  @override
  void dispose() {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    _viewModel.reset();
    super.dispose();
  }
}
