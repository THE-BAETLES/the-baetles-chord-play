import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            HomeHeader(),

            Container(height: 30),

            VideoListBlock(
              videos: viewModel.collectionVideos ?? UnmodifiableListView([]),
              onVideoClicked: (Video video) {
                viewModel.onVideoClicked(context, video);
              },
            ),

            Container(height: 40),

            VideoGridBlock(
              videos: viewModel.recommendedVideos ?? UnmodifiableListView([]),
              onVideoClicked: (Video video) {
                viewModel.onVideoClicked(context, video);
              },
            ),
          ],
        ),
      ),
    );
  }
}
