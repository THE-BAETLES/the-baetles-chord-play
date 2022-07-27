import 'chord_block.dart';

class SheetMusic {
  final String id;
  final String videoId;
  final String userId;
  final String title;
  final DateTime createAt;
  final DateTime updateAt;
  final int likeCount;

  SheetMusic({
    required this.id,
    required this.videoId,
    required this.userId,
    required this.title,
    required this.createAt,
    required this.updateAt,
    required this.likeCount,
  });
}
