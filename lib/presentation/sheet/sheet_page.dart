import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/sheet/sheet_view_model.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_thumbnail.dart';
import 'package:the_baetles_chord_play/widget/molecule/simple_tab_bar.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_sheet_item.dart';

import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/like_count.dart';
import '../../widget/organism/simple_app_bar.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({Key? key}) : super(key: key);

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  @override
  Widget build(BuildContext context) {
    SheetViewModel viewModel = context.watch<SheetViewModel>();

    if (viewModel.shouldRoute) {
      String routeName = viewModel.routeName!;
      Object? arguments = viewModel.routeArguments;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(
          context,
          routeName,
          arguments: arguments,
        );
      });

      viewModel.onCompleteRoute();
    }

    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      appBar: const SimpleAppBar(
        title: "악보",
        dividerHeight: 0,
      ),
      body: DefaultTabController(
          length: 2,
          child: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tabBar(),
                  const Divider(
                    height: 3,
                    thickness: 1,
                    color: AppColors.grayE9,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _sheetList(
                          context: context,
                          videos: viewModel.videosOfMySheets,
                          sheets: viewModel.mySheets ?? [],
                          onClickLikeButton: (SheetInfo sheetInfo) {
                            viewModel.onClickLikeButton(sheetInfo);
                          },
                          onClickItem: (SheetInfo sheetInfo) {
                            viewModel.onClickSheetItem(sheetInfo);
                          },
                        ),
                        _sheetList(
                          context: context,
                          videos: viewModel.videosOfLikedSheets,
                          sheets: viewModel.likedSheets ?? [],
                          onClickLikeButton: (SheetInfo sheetInfo) {
                            viewModel.onClickLikeButton(sheetInfo);
                          },
                          onClickItem: (SheetInfo sheetInfo) {
                            viewModel.onClickSheetItem(sheetInfo);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget _tabBar() {
    return SimpleTabBar(
      tabs: const [
        Tab(
          height: 40,
          child: Text("내 악보"),
        ),
        Tab(
          height: 40,
          child: Text("좋아요"),
        ),
      ],
    );
  }

  Widget _sheetList({
    required BuildContext context,
    required List<Video?>? videos,
    required List<SheetInfo> sheets,
    required Function(SheetInfo sheetInfo) onClickLikeButton,
    required Function(SheetInfo clickedSheet) onClickItem,
  }) {
    const double likeButtonWidth = 70;

    return ListView.builder(
      itemCount: sheets.length,
      itemBuilder: (BuildContext context, int index) {
        SheetInfo sheet = sheets[index];
        Video? video;

        if (videos != null && videos.length == sheets.length) {
          video = videos[index];
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  onClickItem(sheet);
                },
                child: Ink(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                    bottom: 10,
                  ),
                  width: MediaQuery.of(context).size.width - likeButtonWidth,
                  child: VideoSheetItem(
                    thumbnailPath: video?.thumbnailPath ?? "",
                    height: 80,
                    sheetTitle: sheet.title,
                    videoTitle: video?.title ?? "",
                    isLiked: sheet.liked,
                    likeCount: sheet.likeCount,
                  ),
                ),
              ),
              _likeButton(
                sheet.likeCount,
                sheet.liked,
                () => onClickLikeButton(sheet),
                100,
                likeButtonWidth,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _likeButton(
    int likeCount,
    bool isLiked,
    Function() onClick,
    double height,
    double width,
  ) {
    return Material(
      child: InkWell(
        onTap: onClick,
        child: Ink(
          padding: EdgeInsets.only(right: 10),
          width: width,
          height: height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LikeCount(
                count: likeCount,
                width: 20,
                height: 20,
                space: 15,
                color: isLiked ? AppColors.redFF : AppColors.gray80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
