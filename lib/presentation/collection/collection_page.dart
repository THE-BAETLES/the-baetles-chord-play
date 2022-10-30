import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/organism/video_list_view.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/middle_hightlight_text.dart';
import '../../widget/organism/simple_app_bar.dart';
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
      appBar: SimpleAppBar(title: '내 곡 목록',),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: Container(
                color: Colors.white,
                child: Builder(builder: (context) {
                  if (viewModel.myCollection != null &&
                      viewModel.myCollection!.length == 0) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "내 곡 목록이 비어있어요",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray3E,
                          fontFamily: AppFontFamilies.montserrat,
                        ),
                      ),
                    );
                  }

                  return VideoListView(
                    videos: viewModel.myCollection ?? [],
                    onVideoBlockClicked: (Video video) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(context, "/bridge-page",
                            arguments: video);
                      });

                      setState(() {});
                    },
                    head: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 12),
                      child: _itemCountIndicator(
                        viewModel.myCollection?.length ?? 0,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
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
