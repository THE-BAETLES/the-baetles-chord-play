import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/tempo_button.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';

import '../../domain/model/play_option.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/atom/youtube_video_player.dart';
import 'component/svg_toggle_button.dart';
import 'component/toggle_button.dart';
import 'component/transposition_button.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PerformanceViewModel viewModel = context.read<PerformanceViewModel>();

    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width,
      color: AppColors.gray34,
      child: SafeArea(
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
                    child: ValueListenableBuilder(
                      valueListenable: viewModel.isMuted,
                      builder: (context, value, _) {
                        return SvgToggleButton(
                          isToggled: viewModel.isMuted.value,
                          iconPath: 'assets/icons/ic_mute.svg',
                          text: 'Mute',
                          onClick: viewModel.onMuteButtonClicked,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ValueListenableBuilder(
                      valueListenable: viewModel.playOption,
                      builder: (context, value, _) {
                        return SvgToggleButton(
                          isToggled: !viewModel.playOption.value.loop.isInfinite(),
                          iconPath: 'assets/icons/ic_repeat.svg',
                          text: 'Repeat',
                          onClick: viewModel.onRepeatButtonClicked,
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TempoButton(
                      onChangeTempo: (double newTempo) {
                        viewModel.onChangeTempo(newTempo);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TranspositionButton(),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: viewModel.playOption,
                builder: (context, value, _) {
                  return _controlButtons(
                    context,
                    viewModel.play,
                    viewModel.stop,
                    viewModel.moveCurrentPosition,
                    viewModel.playOption.value,
                  );
                }),
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
                      child: ValueListenableBuilder(
                          valueListenable: viewModel.youtubePlayerController,
                          builder: (context, value, _) {
                            if (viewModel.youtubePlayerController.value ==
                                null) {
                              return Text("동영상을 불러올 수 없습니다.");
                            } else {
                              return YoutubeVideoPlayer(
                                controller:
                                    viewModel.youtubePlayerController.value!,
                              );
                            }
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ValueListenableBuilder(
                      valueListenable: viewModel.isPitchBeingChecked,
                      builder: (context, value, _) {
                        return SvgToggleButton(
                          isToggled: viewModel.isPitchBeingChecked.value,
                          iconPath: 'assets/icons/ic_check2.svg',
                          text: 'Check On',
                          onClick: viewModel.onCheckButtonClicked,
                        );
                      },
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
      ),
    );
  }

  Widget _controlButtons(
    BuildContext context,
    void Function() play,
    void Function() stop,
    void Function(int) move,
    PlayOption playOption,
  ) {
    return SizedBox(
      width: 144,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  double secondPerBeat = 1 / (playOption.defaultBpm / 60.0);
                  int changeAmount = (8 * secondPerBeat * 1000).toInt();
                  move(-changeAmount);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: SvgPicture.asset(
                    "assets/icons/ic_prev_2.svg",
                    width: 26,
                    height: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (playOption.isPlaying) {
                    stop();
                  } else {
                    play();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: playOption.isPlaying
                      ? SvgPicture.asset(
                          "assets/icons/ic_pause.svg",
                          width: 22,
                          height: 22,
                        )
                      : SvgPicture.asset(
                          "assets/icons/ic_play2.svg",
                          width: 22,
                          height: 22,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  double secondPerBeat = 1 / (playOption.defaultBpm / 60.0);
                  int changeAmount = (8 * secondPerBeat * 1000).toInt();
                  move(changeAmount);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SvgPicture.asset(
                    "assets/icons/ic_next_2.svg",
                    width: 26,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
