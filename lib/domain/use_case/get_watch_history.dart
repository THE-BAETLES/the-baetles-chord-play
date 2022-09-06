import '../../data/repository/video_repository.dart';
import '../model/video.dart';

class GetWatchHistory {
  final VideoRepository _videoRepository;

  GetWatchHistory(this._videoRepository);

  Future<List<Video>> call({int offset = 0, int limit = 25}) async {
    List<Video> watchHistory = await _videoRepository.getWatchHistory(offset: offset, limit: limit);
    return watchHistory;
  }
}