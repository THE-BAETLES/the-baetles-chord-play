import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

import '../../../schema/video/video_schema.dart';
part 'get_search_response.g.dart';

@JsonSerializable()
class GetSearchResponse extends Response<List<VideoSchema>>{
  GetSearchResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data: data);
  factory GetSearchResponse.fromJson(Map<String, dynamic> json) => _$GetSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchResponseToJson(this);
}