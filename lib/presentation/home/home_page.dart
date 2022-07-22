import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_baetles_chord_play/presentation/home/recommendation_block.dart';
import 'package:the_baetles_chord_play/presentation/home/recommendation_list.dart';

import '../../widget/atom/app_colors.dart';
import 'history_block.dart';
import 'home_header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColors.blue4E),
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header
              HomeHeader(),

              Container(height: 30),

              HistoryBlock(),

              Container(height: 40),

              RecommendationBlock(),
            ],
          ),
        ),
      ),
      // body: Container(
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     children: [
      //       SearchBar(),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width / 2,
      //         child: ElevatedButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, '/bridge-screen');
      //           },
      //           child: Image.network(
      //             YoutubePlayerController.getThumbnail(
      //               videoId: 'WxM0qO29RM8',
      //               quality: ThumbnailQuality.high,
      //             ),
      //             fit: BoxFit.fitWidth,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
