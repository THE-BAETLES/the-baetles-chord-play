import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_recommended_video.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';

import '../../domain/model/video.dart';

class HomeViewModel with ChangeNotifier {
  final GetVideoCollection _getVideoCollection;
  final GetRecommendedVideo _getRecommendedVideo;

  UnmodifiableListView<Video>? collectionVideos;
  UnmodifiableListView<Video>? recommendedVideos;

  HomeViewModel(this._getVideoCollection, this._getRecommendedVideo) {
    _loadContent();
  }

  Future<void> _loadContent() async {
    List<Future<void>> tasks = [];

    tasks.add(Future(() async {
      collectionVideos = await _getVideoCollection();
    }));

    tasks.add(Future(() async {
      recommendedVideos = await _getRecommendedVideo();
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
}
