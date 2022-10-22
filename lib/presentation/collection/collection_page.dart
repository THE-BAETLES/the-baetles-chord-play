import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/organism/video_list_view.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/middle_hightlight_text.dart';
import 'collection_view_model.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    CollectionViewModel viewModel = context.watch<CollectionViewModel>();

    return Scaffold(
      extendBody: false,
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: Container(
                color: Colors.white,
                child: VideoListView(
                  videos: viewModel.myCollection ?? [],
                  onVideoBlockClicked: (Video video) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(context, "/bridge-page",
                          arguments: video);
                    });

                    setState(() {});
                  },
                  head: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 12),
                    child: _itemCountIndicator(
                      viewModel.myCollection?.length ?? 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.5),
        child: Container(
          color: AppColors.grayE3,
          height: 1.5,
        ),
      ),
      elevation: 0,
      title: const Text("내 곡 목록"),
      titleTextStyle: const TextStyle(
        color: AppColors.black04,
        fontFamily: AppFontFamilies.pretendard,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _itemCountIndicator(int videoCount) {
    return MiddleHighlightText(
      leftText: "총 ",
      middleText: videoCount.toString(),
      rightText: "건",
    );
  }
}
