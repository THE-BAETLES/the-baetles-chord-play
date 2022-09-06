import '../../data/repository/video_repository.dart';
import '../model/video.dart';

class SearchVideo {
  final VideoRepository _videoRepository;

  SearchVideo(this._videoRepository);

  Future<List<Video>> call(String searchTitle) async {
    return _videoRepository.searchVideo(searchTitle);
  }
}