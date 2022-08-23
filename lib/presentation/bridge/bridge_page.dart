import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog.dart';
import 'package:the_baetles_chord_play/presentation/bridge/video_info_card.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:the_baetles_chord_play/widget/molecule/middle_hightlight_text.dart';
import 'package:the_baetles_chord_play/widget/organism/transparent_appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../domain/model/instrument.dart';
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
    BridgeViewModel viewModel = context.watch<BridgeViewModel>();
    Video video = ModalRoute.of(context)!.settings.arguments as Video;
    viewModel.onPageBuild(context, video);

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
                controller: viewModel.youtubePlayerController!,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      VideoInfoCard(
                        video: video,
                        onChangeInstrument: (Instrument? instrument) {
                          viewModel.onChangeInstrument(instrument);
                        },
                      ),
                      const Divider(
                        color: AppColors.grayF8,
                        thickness: 8,
                      ),
                      _tabController(context, viewModel),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Visibility(
            visible: true,
            child: Positioned(
              bottom: 0,
              child: BridgeControlBar(),
            ),
          ),
          Visibility(
            visible: viewModel.isInputSheetDetailPopupVisible,
            child: SheetCreationDialog(),
          )
        ],
      ),
    );
  }

  Widget _tabController(BuildContext context, BridgeViewModel viewModel) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
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
                  height: 40,
                  child: Text("내 악보"),
                ),
                Tab(
                  height: 40,
                  child: Text("좋아요"),
                ),
                Tab(
                  height: 40,
                  child: Text("공유된 악보"),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MiddleHighlightText(
                    leftText: "총 ",
                    middleText: viewModel.sheetCount.toString(),
                    rightText: "개의 악보",
                  ),
                  AddSheetButton(onClick: viewModel.onClickCreateSheetButton),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: TabBarView(
                children: [
                  BridgeSheetListView(
                    sheets: viewModel.mySheets,
                    videoTitle: viewModel.video?.title ?? "",
                  ),
                  BridgeSheetListView(
                    sheets: viewModel.likedSheets,
                    videoTitle: viewModel.video?.title ?? "",
                  ),
                  BridgeSheetListView(
                    sheets: viewModel.sharedSheets,
                    videoTitle: viewModel.video?.title ?? "",
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
