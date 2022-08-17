import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/domain/model/sheet_info.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';

part 'sheet_schema.g.dart';

@JsonSerializable()
class SheetSchema {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'video_id')
  String videoId;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @JsonKey(name: 'like_count')
  int likeCount;

  SheetSchema(
      {required this.id,
      required this.videoId,
      required this.userId,
      required this.title,
      required this.createdAt,
      required this.updatedAt,
      required this.likeCount});

  factory SheetSchema.fromJson(Map<String, dynamic> json) =>
      _$SheetSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$SheetSchemaToJson(this);

  SheetInfo toSheetInfo() {
    return SheetInfo(
      id: id,
      videoId: videoId,
      userId: userId,
      title: title,
      createAt: createdAt,
      updateAt: updatedAt,
      likeCount: likeCount,
    );
  }
}
