import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/beat_tile.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/mute_button.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';
import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/presentation/performance/sheet_state.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 방향으로 고정함
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    List<dynamic> arguments = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    Video video = arguments[0] as Video;
    SheetInfo sheetInfo = arguments[1] as SheetInfo;
    SheetData sheetData = arguments[2] as SheetData;

    PerformanceViewModel viewModel = context.watch<PerformanceViewModel>();
    viewModel.initViewModel(video: video, sheetInfo: sheetInfo, sheetData: sheetData);

    print("hi!");

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
              child: _sheetView(context, viewModel.playState, viewModel.sheetState),
            ),
            Positioned(
              bottom: 0,
              child: _controlBar(context, viewModel.play, viewModel.playState, viewModel.youtubePlayerController),
            )
          ],
        ),
      ),
    );
  }

  Widget _sheetView(BuildContext context, PlayState playState, SheetState sheetState) {
    return BeatTile(chord: "A");
  }

  Widget _controlBar(BuildContext context, void Function() play, PlayState playState, final YoutubePlayerController controller) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width,
      color: AppColors.gray34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MuteButton(
            isToggled: false,
            iconPath: 'assets/icons/ic_mute.svg',
            text: 'Mute',
          ),
          _controlButtons(context, play, playState.isPlaying),
          Container(
            child: YoutubeVideoPlayer(controller: controller),
          )
        ],
      ),
    );
  }

  Widget _controlButtons(BuildContext context, void Function() play, bool isPlaying) {
    return Container(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/icons/ic_prev_2.svg", width: 26, height: 30),
          GestureDetector(
            onTap: () {
              play();
            },
            child: isPlaying ? SvgPicture.asset("assets/icons/ic_play2.svg", width: 22, height: 22)
                      : SvgPicture.asset("assets/icons/ic_pause.svg", width: 22, height: 22),
          ),
          SvgPicture.asset("assets/icons/ic_next_2.svg", width: 26, height: 30),
        ],
      ),
    );
  }
}
