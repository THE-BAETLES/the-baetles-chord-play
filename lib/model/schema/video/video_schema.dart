import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/domain/model/video.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';

part 'video_schema.g.dart';

@JsonSerializable()
class VideoSchema {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'thumbnail_path')
  String thumbnailPath;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'genre')
  String genre;

  @JsonKey(name: 'singer')
  String singer;

  @JsonKey(name: 'tags')
  List<String> tags;

  @JsonKey(name: 'length')
  int length;

  @JsonKey(name: 'difficulty_avg')
  int difficultyAvg;

  @JsonKey(name: 'play_count')
  int playCount;

  @JsonKey(name: 'sheet_count')
  int sheetCount;

  @JsonKey(name: 'is_in_my_collection')
  bool isInMyCollection;

  VideoSchema({
    required this.id,
    required this.thumbnailPath,
    required this.title,
    required this.genre,
    required this.singer,
    required this.tags,
    required this.length,
    required this.difficultyAvg,
    required this.playCount,
    required this.sheetCount,
    required this.isInMyCollection,
  });

  factory VideoSchema.fromJson(Map<String, dynamic> json) =>
      _$VideoSchemaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VideoSchemaToJson(this);

  factory VideoSchema.fromVideo(Video video) {
    return VideoSchema(
      id: video.id,
      thumbnailPath: video.thumbnailPath,
      title: video.title,
      genre: video.genre,
      singer: video.singer,
      tags: video.tags,
      length: video.length,
      difficultyAvg: video.difficultyAvg,
      playCount: video.playCount,
      sheetCount: video.sheetCount,
      isInMyCollection: video.isInMyCollection,
    );
  }

  Video toVideo() {
    return Video(
      id: id,
      thumbnailPath: thumbnailPath,
      title: title,
      genre: genre,
      singer: singer,
      tags: tags,
      length: length,
      difficultyAvg: difficultyAvg,
      playCount: playCount,
      sheetCount: sheetCount,
      isInMyCollection: isInMyCollection,
    );
  }
}
