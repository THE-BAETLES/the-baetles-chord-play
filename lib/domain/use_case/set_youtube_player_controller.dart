import 'package:the_baetles_chord_play/service/conductor/youtube_conductor_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SetYoutubePlayerController {
  YoutubeConductorService _youtubeConductorService;

  SetYoutubePlayerController(
    YoutubeConductorService youtubeConductorService,
  ) : _youtubeConductorService = youtubeConductorService;

  void call(YoutubePlayerController youtubePlayerController) {
    _youtubeConductorService.setYoutubeController(youtubePlayerController);
  }
}
