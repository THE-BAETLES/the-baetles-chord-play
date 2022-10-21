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
      body: _homePage(context, viewModel),
    );
  }

  Widget _homePage(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // header
          HomeHeader(userName: viewModel.userName),

          Container(height: 30),

          VideoListBlock(
            userName: viewModel.userName,
            videos: viewModel.collectionVideos ?? [],
            onVideoClicked: (Video video) {
              viewModel.onVideoClicked(context, video);
            },
          ),

          Container(height: 40),

          VideoGridBlock(
            videos: viewModel.recommendedVideos,
            onVideoClicked: (Video video) {
              viewModel.onVideoClicked(context, video);
            },
            scrollListener: (double offset, double maxScrollExtent) {
              viewModel.onScrollRecommendVideos(offset, maxScrollExtent);
            },
          ),

          Container(
            height: 60,
          ),
        ],
      ),
    );
  }
}
