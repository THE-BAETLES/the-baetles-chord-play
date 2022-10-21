import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_nickname.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_watch_history.dart';

import '../../domain/model/video.dart';

class HomeViewModel with ChangeNotifier {
  final int maxListLength = 100;

  final GetVideoCollection _getVideoCollection;
  final GetRecommendedVideo _getRecommendedVideo;
  final GetWatchHistory _getWatchHistory;
  final GetUserNickname _getUserNickname;
  final recommendedVideoLoadingLock = Mutex();

  late final String userName;

  List<Video>? collectionVideos;
  List<Video> recommendedVideos = [];

  HomeViewModel(
    this._getVideoCollection,
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
      collectionVideos = (await _getWatchHistory());
    }));

    tasks.add(Future(() async {
      recommendedVideos.addAll(await _getRecommendedVideo());
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

  void onScrollRecommendVideos(double offset, maxOffset) async {
    int initRecommendedVideoCount = recommendedVideos.length;
    if (initRecommendedVideoCount < maxListLength &&
        (maxOffset - offset < 300 || maxOffset < 300) &&
        !recommendedVideoLoadingLock.isLocked) {
      await recommendedVideoLoadingLock.acquire();

      if ((recommendedVideos.length) == initRecommendedVideoCount) {
        List<Video> newVideos = await _getRecommendedVideo(
            offset: recommendedVideos.length, limit: 30);

        recommendedVideos.addAll(newVideos);

        notifyListeners();
      }

      recommendedVideoLoadingLock.release();
    }
  }
}
