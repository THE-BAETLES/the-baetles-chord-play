import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog.dart';
import 'package:the_baetles_chord_play/presentation/bridge/video_info_card.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/atom/youtube_video_player.dart';
import 'package:the_baetles_chord_play/widget/molecule/block_title.dart';
import 'package:the_baetles_chord_play/widget/molecule/middle_hightlight_text.dart';
import 'package:the_baetles_chord_play/widget/molecule/confirm_dialog.dart';
import 'package:the_baetles_chord_play/widget/organism/transparent_appbar.dart';

import '../../domain/model/instrument.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/collection_button.dart';
import '../../widget/molecule/create_sheet_button.dart';
import 'bridge_control_bar.dart';
import 'bridge_sheet_list_view.dart';
import 'bridge_view_model.dart';

class BridgePage extends StatefulWidget {
  const BridgePage({Key? key}) : super(key: key);

  @override
  State<BridgePage> createState() => _BridgePageState();
}

class _BridgePageState extends State<BridgePage> {
  BridgeViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    BridgeViewModel viewModel = context.watch<BridgeViewModel>();
    Video video = ModalRoute.of(context)!.settings.arguments as Video;
    viewModel.onPageBuild(context, video);

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: TransparentAppbar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SlidingUpPanel(
              controller: _panelController(
                isOpen: viewModel.isCreatingSheet,
              ),
              onPanelClosed: () {
                viewModel.onCancelCreatingSheet();
              },
              minHeight: 0,
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  60,
              isDraggable: true,
              borderRadius: BorderRadius.circular(12),
              panel: _sheetSelector(
                  context: context,
                  sheets: viewModel.sharedSheets ?? UnmodifiableListView([]),
                  videoTitle: viewModel.video?.title ?? "",
                  onClick: (BuildContext context, SheetInfo sheetInfo) {
                    viewModel.onSelectSheetToDuplicate(sheetInfo);
                  }),
              body: Column(
                children: [
                  Builder(
                    builder: (context) {
                      if (viewModel.youtubePlayerController == null) {
                        return Container(
                          color: AppColors.black04,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * (9/16),
                        );
                      }

                      return YoutubeVideoPlayer(
                        controller: viewModel.youtubePlayerController!,
                      );
                    }
                  ),
                  VideoInfoCard(
                    video: video,
                    onChangeInstrument: (Instrument? instrument) {
                      viewModel.onChangeInstrument(instrument);
                    },
                    collectionButton: ValueListenableBuilder(
                        valueListenable: viewModel.isVideoIncludedInCollection,
                        builder: (context, value, _) {
                          return _collectionButton(
                            onClickCollectionButton:
                                viewModel.onClickCollectionButton,
                            isIncluded:
                                viewModel.isVideoIncludedInCollection.value,
                          );
                        }),
                  ),
                  const Divider(
                    color: AppColors.grayF8,
                    thickness: 8,
                  ),
                  Expanded(
                    child: _tabController(context, viewModel),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: ValueListenableBuilder(
              valueListenable: viewModel.isSettingSheet,
              builder: (context, value, _) {
                return Visibility(
                  visible: viewModel.isSettingSheet.value,
                  child: Container(
                    color: AppColors.shadow00,
                    child: SheetCreationDialog(),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: ValueListenableBuilder(
              valueListenable: viewModel.isDeletingSheet,
              builder: (context, value, _) {
                return Visibility(
                    visible: viewModel.isDeletingSheet.value,
                    child: Container(
                      color: AppColors.shadow00,
                      child: ConfirmDialog(
                        title: "악보 삭제",
                        body: Text("이 작업은 되돌릴 수 없습니다."),
                        onClickConfirmButton: () {
                          viewModel.onClickDeleteButton();
                        },
                        onClickCancelButton: () {
                          viewModel.onClickCancelDeletingButton();
                        },
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = context.read<BridgeViewModel>();
  }

  @override
  void dispose() {
    _viewModel?.reset();
    super.dispose();
  }

  Widget _tabController(BuildContext context, BridgeViewModel viewModel) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
        final tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          viewModel.onChangeTabIndex(tabController.index);
        });

        tabController.animateTo(viewModel.tabBarOffset);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TabBar(
              physics: BouncingScrollPhysics(),
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
              labelColor: AppColors.mainPointColor,
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
              indicatorColor: AppColors.mainPointColor,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            const Divider(
              height: 3,
              thickness: 1,
              color: AppColors.grayE9,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 50,
                    child: TabBarView(
                      children: [
                        BridgeSheetListView(
                          sheets: viewModel.mySheets,
                          videoTitle: viewModel.video?.title ?? "",
                          onClick: viewModel.onSelectSheet,
                          onLongClicked: viewModel.onLongClickSheet,
                        ),
                        BridgeSheetListView(
                          sheets: viewModel.likedSheets,
                          videoTitle: viewModel.video?.title ?? "",
                          onClick: viewModel.onSelectSheet,
                          onLongClicked: viewModel.onLongClickSheet,
                        ),
                        BridgeSheetListView(
                          sheets: viewModel.sharedSheets,
                          videoTitle: viewModel.video?.title ?? "",
                          onClick: viewModel.onSelectSheet,
                          onLongClicked: viewModel.onLongClickSheet,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MiddleHighlightText(
                            leftText: "총 ",
                            middleText: viewModel.sheetCount.toString(),
                            rightText: "개의 악보",
                          ),
                          CreateSheetButton(onClick: () {
                            viewModel.onClickCreateSheetButton(context);
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  PanelController _panelController({
    required ValueNotifier<bool> isOpen,
  }) {
    PanelController controller = PanelController();

    var callback;

    callback = () {
      try {
        if (isOpen.value) {
          controller.show();
          controller.open();
        } else {
          controller.close();
        }
      } catch (e) {
        isOpen.removeListener(callback);
        return;
      }
    };

    isOpen.addListener(callback);

    return controller;
  }

  Widget? _sheetSelector({
    required BuildContext context,
    required UnmodifiableListView<SheetInfo> sheets,
    required String videoTitle,
    required Function(BuildContext, SheetInfo) onClick,
  }) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
          child: BlockTitle(
            title: "악보 생성",
            subTitle: "복제할 악보를 선택해주세요",
          ),
        ),
        Expanded(
          child: BridgeSheetListView(
            sheets: sheets,
            videoTitle: videoTitle,
            onClick: onClick,
          ),
        ),
      ],
    );
  }

  Widget _collectionButton({
    required final Function() onClickCollectionButton,
    required final bool isIncluded,
  }) {
    return InkWell(
      onTap: onClickCollectionButton,
      child: Container(
        width: 50,
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CollectionButton(
              width: 25,
              height: 25,
              isIncluded: isIncluded,
            ),
            Container(height: 6.4),
            Text(
              isIncluded ? "목록 제거" : "목록 담기",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: AppFontFamilies.notosanskr,
                fontSize: 10,
                color: AppColors.gray80,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
