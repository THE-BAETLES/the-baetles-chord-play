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

  @JsonKey(name: 'liked')
  bool liked;

  SheetSchema({
    required this.id,
    required this.videoId,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.likeCount,
    required this.liked,
  });

  factory SheetSchema.fromJson(Map<String, dynamic> json) => _$SheetSchemaFromJson(json);

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
        liked: liked,
    );
  }
}

@JsonSerializable()
class AllSheetSchema {
  @JsonKey(name: 'shared')
  List<SheetSchema> sharedList;

  @JsonKey(name: 'like')
  List<SheetSchema> likeList;

  @JsonKey(name: 'my')
  List<SheetSchema> myList;

  AllSheetSchema(
      {required this.sharedList, required this.likeList, required this.myList});

  factory AllSheetSchema.fromJson(Map<String, dynamic> json) =>
      _$AllSheetSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$AllSheetSchemaToJson(this);

  Map<String, List<SheetInfo>> toMap() {
    Map<String, List<SheetInfo>> result = {};
    result['shared'] = sharedList.map((e) => e.toSheetInfo()).toList();
    result['like'] = likeList.map((e) => e.toSheetInfo()).toList();
    result['my'] = myList.map((e) => e.toSheetInfo()).toList();
    return result;
  }
}