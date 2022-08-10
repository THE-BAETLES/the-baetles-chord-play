import 'chord_block.dart';

class SheetInfo {
  final String id;
  final String videoId;
  final String userId;
  final String title;
  final DateTime createAt;
  final DateTime updateAt;
  final int likeCount;

  SheetInfo({
    required this.id,
    required this.videoId,
    required this.userId,
    required this.title,
    required this.createAt,
    required this.updateAt,
    required this.likeCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SheetInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          videoId == other.videoId &&
          userId == other.userId &&
          title == other.title &&
          createAt == other.createAt &&
          updateAt == other.updateAt &&
          likeCount == other.likeCount;

  @override
  int get hashCode =>
      id.hashCode ^
      videoId.hashCode ^
      userId.hashCode ^
      title.hashCode ^
      createAt.hashCode ^
      updateAt.hashCode ^
      likeCount.hashCode;
}
