import 'dart:collection';

import 'package:the_baetles_chord_play/domain/model/performer_grade.dart';

import '../../data/repository/video_repository.dart';
import '../model/video.dart';
import 'get_user_country.dart';

class GetMusicToCheckPreference {
  final VideoRepository _videoRepository;
  final GetUserCountry _getUserCountry;

  GetMusicToCheckPreference(this._videoRepository, this._getUserCountry);

  Future<UnmodifiableListView<Video>> call(PerformerGrade performerGrade) async {
    return _videoRepository.fetchVideosToCheckPreference((await _getUserCountry()), performerGrade);
  }
}