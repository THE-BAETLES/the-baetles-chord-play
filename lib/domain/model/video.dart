class Video {
  final String id;
  final String thumbnailPath;
  final String title;
  final String genre;
  final String singer;
  final List<String> tags;
  final int length;
  final int difficulty;
  final int playCount;

  Video({
    required this.id,
    required this.thumbnailPath,
    required this.title,
    required this.genre,
    required this.singer,
    required this.tags,
    required this.length,
    required this.difficulty,
    required this.playCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          thumbnailPath == other.thumbnailPath &&
          title == other.title &&
          genre == other.genre &&
          singer == other.singer &&
          difficulty == other.difficulty &&
          playCount == other.playCount;

  @override
  int get hashCode =>
      id.hashCode ^
      thumbnailPath.hashCode ^
      title.hashCode ^
      genre.hashCode ^
      singer.hashCode ^
      difficulty.hashCode ^
      playCount.hashCode;
}
