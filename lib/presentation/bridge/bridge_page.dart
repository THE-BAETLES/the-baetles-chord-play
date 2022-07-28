import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/video_info_card.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:the_baetles_chord_play/widget/molecule/middle_hightlight_text.dart';
import 'package:the_baetles_chord_play/widget/organism/transparent_appbar.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/add_sheet_button.dart';
import 'bridge_control_bar.dart';
import 'bridge_sheet_list_view.dart';
import 'bridge_view_model.dart';

class BridgePage extends StatelessWidget {
  const BridgePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Video video = ModalRoute.of(context)!.settings.arguments as Video;
    BridgeViewModel viewModel = context.watch<BridgeViewModel>();
    viewModel.onPageInit(video);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: TransparentAppbar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              YoutubeVideoPlayer(
                vid: video.id,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      VideoInfoCard(
                        video: video,
                      ),
                      const Divider(
                        color: AppColors.grayF8,
                        thickness: 8,
                      ),
                      DefaultTabController(
                        length: 3,
                        child: Builder(
                          builder: (context) {
                            final tabController = DefaultTabController.of(context)!;
                            tabController.addListener(() {
                              viewModel.onChangeTabIndex(tabController.index);
                            });

                            return Wrap(
                              children: [
                                const TabBar(
                                  isScrollable: true,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  tabs: [
                                    Tab(
                                      child: Text("내 악보"),
                                      height: 40,
                                    ),
                                    Tab(
                                      child: Text("좋아요"),
                                      height: 40,
                                    ),
                                    Tab(
                                      child: Text("공유된 악보"),
                                      height: 40,
                                    ),
                                  ],
                                  labelColor: AppColors.blue4E,
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFontFamilies.pretendard,
                                  ),
                                  unselectedLabelColor: AppColors.gray80,
                                  unselectedLabelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppFontFamilies.pretendard,
                                  ),
                                  indicatorColor: AppColors.blue4E,
                                  indicatorSize: TabBarIndicatorSize.label,
                                ),
                                const Divider(
                                  height: 3,
                                  thickness: 1,
                                  color: AppColors.grayE9,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      MiddleHighlightText(
                                        leftText: "총 ",
                                        middleText: viewModel.sheetCount.toString(),
                                        rightText: "개의 악보",
                                      ),
                                      AddSheetButton(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 500,
                                  child: TabBarView(
                                    children: [
                                      BridgeSheetListView(
                                        sheets: viewModel.mySheets,
                                        videoTitle: video.title,
                                      ),
                                      BridgeSheetListView(
                                        sheets: viewModel.likedSheets,
                                        videoTitle: video.title,
                                      ),
                                      BridgeSheetListView(
                                        sheets: viewModel.sharedSheets,
                                        videoTitle: video.title,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: true,
            child: Positioned(
              bottom: 0,
              // TODO : control box 만들기
              child: BridgeControlBar(),
            ),
          ),
        ],
      ),
    );
  }
}
