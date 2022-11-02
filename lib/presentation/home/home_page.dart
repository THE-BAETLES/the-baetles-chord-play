import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/home/video_grid_block.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import 'home_view_model.dart';
import 'video_list_block.dart';
import 'home_header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: AppColors.mainPointColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: _homePage(
        context,
        viewModel,
        [
          _watchHistoryBlock(context, viewModel),
          _recommendBlock(context, viewModel),
        ],
      ),
    );
  }

  Widget _homePage(
    BuildContext context,
    HomeViewModel viewModel,
    List<Widget> blocks,
  ) {
    List<Widget> children = [
      // header
      HomeHeader(userName: viewModel.userName),
      Container(height: 30),
    ];

    // content
    for (Widget block in blocks) {
      children.add(block);
      children.add(Container(height: 40)); // divider
    }

    // footer
    children.add(Container(height: 60));

    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _watchHistoryBlock(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.watchHistory.isEmpty) {
      return Container(height: 0);
    }

    return VideoListBlock(
      title: "연주했던 곡",
      subTitle: "${viewModel.userName}님이 연습했던 악보영상들",
      videos: viewModel.watchHistory ?? [],
      onVideoClicked: (Video video) {
        viewModel.onVideoClicked(context, video);
      },
      scrollListener: (double offset, double maxScrollExtent) {
        viewModel.onScrollWatchHistory(offset, maxScrollExtent);
      },
    );
  }

  Widget _recommendBlock(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.recommendedVideos.isEmpty) {
      return Container(height: 0);
    }

    return VideoGridBlock(
      videos: viewModel.recommendedVideos,
      onVideoClicked: (Video video) {
        viewModel.onVideoClicked(context, video);
      },
      scrollListener: (double offset, double maxScrollExtent) {
        viewModel.onScrollRecommendVideos(offset, maxScrollExtent);
      },
    );
  }
}
