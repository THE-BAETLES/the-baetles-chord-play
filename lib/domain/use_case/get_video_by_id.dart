import 'package:the_baetles_chord_play/data/repository/video_repository.dart';

import '../model/video.dart';

class GetVideoById {
  final VideoRepository _videoRepository;

  GetVideoById(this._videoRepository);

  Future<Video?> call(String videoId) async {
    return _videoRepository.getVideoById(videoId);
  }
}