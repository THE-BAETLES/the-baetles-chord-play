import 'package:the_baetles_chord_play/data/repository/video_repository.dart';

import '../model/video.dart';

class GenerateVideo {
  VideoRepository _videoRepository;

  GenerateVideo(this._videoRepository);

  Future<void> call(Video video) async {
    _videoRepository.generateVideo(video);
  }
}