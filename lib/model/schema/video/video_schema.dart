import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/domain/model/video.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';

part 'video_schema.g.dart';

@JsonSerializable()
class VideoSchema implements Schema<Video> {
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

  @JsonKey(name: 'difficultyAvg')
  int difficultyAvg;

  @JsonKey(name: 'play_count')
  int playCount;

  VideoSchema(
      {required this.id,
      required this.thumbnailPath,
      required this.title,
      required this.genre,
      required this.singer,
      required this.tags,
      required this.length,
      required this.difficultyAvg,
      required this.playCount});

  factory VideoSchema.fromJson(Map<String, dynamic> json) =>
      _$VideoSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$VideoSchemaToJson(this);
}
