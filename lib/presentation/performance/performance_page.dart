import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/mute_button.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/organism/sheet_view.dart';

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
        toolbarHeight: 52,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: AppColors.black04,
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.grayF5,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SheetView(
                  currentPosition: viewModel.playState.currentPosition,
                  sheetData: viewModel.sheetState?.sheetData ??
                      SheetData(
                        id: 'hellodummy',
                        bpm: 80,
                        chords: [],
                      ),
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
              ),
            ),
          ],
        ),
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
  ) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width,
      color: AppColors.gray34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MuteButton(
            isToggled: false,
            iconPath: 'assets/icons/ic_mute.svg',
            text: 'Mute',
          ),
          _controlButtons(context, play, stop, move, playState),
          Container(
            width: 62,
            height: 44,
            color: Colors.black,
            child: controller == null
                ? null
                : YoutubeVideoPlayer(controller: controller),
          )
        ],
      ),
    );
  }

  Widget _controlButtons(BuildContext context, void Function() play,
      void Function() stop, void Function(int) move, PlayState playState) {
    return Container(
      width: 140,
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = context.read<PerformanceViewModel>();
  }

  @override
  void dispose() {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _viewModel.dispose();

    super.dispose();
  }
}
