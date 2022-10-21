import 'package:the_baetles_chord_play/data/repository/video_repository.dart';

import '../model/video.dart';

class GenerateVideo {
  VideoRepository _videoRepository;

  GenerateVideo(this._videoRepository);

  Future<Video> call(Video video) async {
    return await _videoRepository.generateVideo(video);
  }
}