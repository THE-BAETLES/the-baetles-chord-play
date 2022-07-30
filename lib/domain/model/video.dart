class Video {
  final String id;
  final String thumbnailPath;
  final String title;
  final String genre;
  final String singer;
  final int difficultyAvg;
  final int playCount;

  Video({
    required this.id,
    required this.thumbnailPath,
    required this.title,
    required this.genre,
    required this.singer,
    required this.difficultyAvg,
    required this.playCount,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      thumbnailPath: json['thumnail_path'], // TODO : 오타 고치기
      title: json['title'],
      genre: json['genre'],
      singer: json['singer'],
      difficultyAvg: json['difficulty_avg'],
      playCount: json['play_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'thumbnail_path': thumbnailPath,
    'title': title,
    'genre': genre,
    'singer': singer,
    'difficulty_avg': difficultyAvg,
    'play_count': playCount,
  };

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
          difficultyAvg == other.difficultyAvg &&
          playCount == other.playCount;

  @override
  int get hashCode =>
      id.hashCode ^
      thumbnailPath.hashCode ^
      title.hashCode ^
      genre.hashCode ^
      singer.hashCode ^
      difficultyAvg.hashCode ^
      playCount.hashCode;
}
