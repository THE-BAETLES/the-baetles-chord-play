import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/home/video_grid_block.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

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
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: AppColors.blue4E,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
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
              videos: viewModel.recommendedVideos ?? UnmodifiableListView([]),
              onVideoClicked: (Video video) {
                viewModel.onVideoClicked(context, video);
              },
            ),

            Container(
              height: 60,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowA1,
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            selectedLabelStyle: const TextStyle(
              fontSize: 9,
              color: AppColors.blue4E,
              fontWeight: FontWeight.w600,
              fontFamily: AppFontFamilies.pretendard,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 9,
              color: AppColors.gray9D,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamilies.pretendard,
            ),
            selectedItemColor: AppColors.blue4E,
            unselectedItemColor: AppColors.gray9D,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_home.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                activeIcon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_home.svg",
                    color: AppColors.blue4E,
                    fit: BoxFit.cover,
                  ),
                ),
                label: "홈",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_folder2.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                activeIcon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_folder2.svg",
                    color: AppColors.blue4E,
                    fit: BoxFit.cover,
                  ),
                ),
                label: "내 곡 목록",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_music_file.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                activeIcon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_music_file.svg",
                    color: AppColors.blue4E,
                    fit: BoxFit.cover,
                  ),
                ),
                label: "악보",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_record1.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                activeIcon: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/icons/ic_record1.svg",
                    color: AppColors.blue4E,
                    fit: BoxFit.cover,
                  ),
                ),
                label: "레코드",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
