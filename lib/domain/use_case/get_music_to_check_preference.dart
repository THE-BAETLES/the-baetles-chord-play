import 'dart:collection';

import 'package:the_baetles_chord_play/domain/model/performer_grade.dart';

import '../../data/repository/video_repository.dart';
import '../model/gender.dart';
import '../model/video.dart';
import 'get_user_country.dart';
import 'get_user_id_token.dart';

class GetMusicToCheckPreference {
  final VideoRepository _videoRepository;
  final GetUserCountry _getUserCountry;
  final GetUserIdToken _getUserIdToken;

  GetMusicToCheckPreference(
      this._videoRepository, this._getUserCountry, this._getUserIdToken);

  Future<UnmodifiableListView<Video>?> call(
    PerformerGrade performerGrade,
    Gender gender,
  ) async {
    return await _videoRepository.fetchVideosToCheckPreference(
      (await _getUserIdToken())!,
      (await _getUserCountry())!,
      performerGrade.name,
      gender.name,
    );
  }
}
