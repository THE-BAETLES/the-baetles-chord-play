import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/performance/fragment/sheet_view.dart';
import 'package:the_baetles_chord_play/presentation/sheet/sheet_view_model.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_thumbnail.dart';
import 'package:the_baetles_chord_play/widget/molecule/simple_tab_bar.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_sheet_item.dart';

import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/molecule/like_count.dart';
import '../../widget/organism/simple_app_bar.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({Key? key}) : super(key: key);

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);

    SheetViewModel viewModel = context.read<SheetViewModel>();
    _controller.addListener(() {
      viewModel.loadSheets();
    });
  }

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
                  _tabBar(this._controller),
                  const Divider(
                    height: 3,
                    thickness: 1,
                    color: AppColors.grayE9,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: this._controller,
                      children: [
                        _mySheetList(context, viewModel),
                        _likeSheetList(context, viewModel),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget _tabBar(TabController? controller) {
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
      controller: controller,
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
                  padding: const EdgeInsets.only(
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

  Widget _mySheetList(BuildContext context, SheetViewModel viewModel) {
    if (viewModel.mySheets == null) {
      return Container(
        alignment: Alignment.center,
        child: LoadingAnimationWidget.prograssiveDots(
          color: AppColors.mainPointColor,
          size: 40,
        ),
      );
    } else if (viewModel.mySheets!.isEmpty) {
      return Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "아직 직접 생성한 악보가 없어요 😅",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.gray3E,
                fontFamily: AppFontFamilies.montserrat,
              ),
            ),
            Text(
              "곡 상세정보 페이지에서 새 악보를 생성할 수 있어요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.black04,
                fontFamily: AppFontFamilies.montserrat,
              ),
            ),
          ],
        ),
      );
    } else {
      return _sheetList(
        context: context,
        videos: viewModel.videosOfMySheets,
        sheets: viewModel.mySheets ?? [],
        onClickLikeButton: (SheetInfo sheetInfo) {
          viewModel.onClickLikeButton(sheetInfo);
        },
        onClickItem: (SheetInfo sheetInfo) {
          viewModel.onClickSheetItem(sheetInfo);
        },
      );
    }
  }

  Widget _likeSheetList(BuildContext context, SheetViewModel viewModel) {
    if (viewModel.likedSheets == null) {
      return Container(
        alignment: Alignment.center,
        child: LoadingAnimationWidget.prograssiveDots(
          color: AppColors.mainPointColor,
          size: 40,
        ),
      );
    } else if (viewModel.likedSheets!.isEmpty) {
      return Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "아직 좋아요 표시한 악보가 없어요 😅",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.gray3E,
                fontFamily: AppFontFamilies.montserrat,
              ),
            ),
            Text(
              "좋아하는 악보에 하트 버튼을 눌러보세요!",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.black04,
                fontFamily: AppFontFamilies.montserrat,
              ),
            ),
          ],
        ),
      );
    } else {
      return _sheetList(
        context: context,
        videos: viewModel.videosOfLikedSheets,
        sheets: viewModel.likedSheets ?? [],
        onClickLikeButton: (SheetInfo sheetInfo) {
          viewModel.onClickLikeButton(sheetInfo);
        },
        onClickItem: (SheetInfo sheetInfo) {
          viewModel.onClickSheetItem(sheetInfo);
        },
      );
    }
  }
}
