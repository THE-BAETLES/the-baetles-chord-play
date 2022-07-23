import 'dart:collection';

import '../../data/repository/auth_repository.dart';
import '../../data/repository/video_repository.dart';
import '../model/video.dart';

class GetVideoCollection {
  final VideoRepository _videoRepository;
  final AuthRepository _authRepository;

  GetVideoCollection(this._videoRepository, this._authRepository);

  Future<UnmodifiableListView<Video>> call() async {
    String idToken = (await _authRepository.fetchIdToken())! as String;
    return await _videoRepository.fetchVideoCollection(idToken);
  }
}