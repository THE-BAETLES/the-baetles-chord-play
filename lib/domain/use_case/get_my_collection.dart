import 'package:the_baetles_chord_play/data/repository/collection_repository.dart';

import '../model/video.dart';

class GetMyCollection {
  final CollectionRepository userRepository;

  GetMyCollection(this.userRepository);

  Future<List<Video>> call() async {
    return await userRepository.getMyCollection();
  }
}
