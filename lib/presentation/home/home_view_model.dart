import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_nickname.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_watch_history.dart';

import '../../domain/model/video.dart';

class HomeViewModel with ChangeNotifier {
  final int maxListLength = 500;
  bool canLoadMoreWatchHistory = true;
  bool canLoadMoreRecommendedVideo = true;

  final GetRecommendedVideo _getRecommendedVideo;
  final GetWatchHistory _getWatchHistory;
  final GetUserNickname _getUserNickname;

  final recommendedVideoLoadingLock = Mutex();
  final watchHistoryLoadingLock = Mutex();

  late final String userName;

  List<Video> watchHistory = [];
  List<Video> recommendedVideos = [];

  HomeViewModel(
    this._getRecommendedVideo,
    this._getWatchHistory,
    this._getUserNickname,
  ) {
    _loadContent();
    userName = _getUserNickname()!;
  }

  Future<void> _loadContent() async {
    List<Future<void>> tasks = [];

    tasks.add(Future(() async {
      watchHistory.addAll(await _getWatchHistory(
        offset: 0,
        limit: 20,
      ));
    }));

    tasks.add(Future(() async {
      recommendedVideos.addAll(await _getRecommendedVideo(
        offset: 0,
        limit: 20,
      ));
    }));

    for (Future<void> task in tasks) {
      await task;
    }

    notifyListeners();
  }

  void onVideoClicked(BuildContext context, Video video) {
    Navigator.pushNamed(
      context,
      '/bridge-page',
      arguments: video,
    );
  }

  void onScrollRecommendVideos(double offset, double maxOffset) async {
    int initialRecommendedVideoCount = recommendedVideos.length;

    if (canLoadMoreRecommendedVideo &&
        initialRecommendedVideoCount < maxListLength &&
        (maxOffset - offset < 300 || maxOffset < 300) &&
        !recommendedVideoLoadingLock.isLocked) {
      await recommendedVideoLoadingLock.acquire();

      if (recommendedVideos.length == initialRecommendedVideoCount) {
        List<Video> newVideos = await _getRecommendedVideo(
          offset: recommendedVideos.length,
          limit: 30,
        );

        if (newVideos.isEmpty) {
          canLoadMoreRecommendedVideo = false;
        } else {
          recommendedVideos.addAll(newVideos);
          notifyListeners();
        }
      }

      recommendedVideoLoadingLock.release();
    }
  }

  void onScrollWatchHistory(double offset, double maxOffset) async {
    int initialWatchHistoryVideoCount = watchHistory.length;

    if (canLoadMoreWatchHistory &&
        initialWatchHistoryVideoCount < maxListLength &&
        (maxOffset - offset < 300 || maxOffset < 300) &&
        !watchHistoryLoadingLock.isLocked) {
      await watchHistoryLoadingLock.acquire();

      if (watchHistory.length == initialWatchHistoryVideoCount) {
        List<Video> newVideos = await _getWatchHistory(
          offset: watchHistory.length,
          limit: 30,
        );

        if (newVideos.isEmpty) {
          canLoadMoreWatchHistory = false;
        } else {
          watchHistory.addAll(newVideos);
          notifyListeners();
        }
      }

      watchHistoryLoadingLock.release();
    }
  }
}
