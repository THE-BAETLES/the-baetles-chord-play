import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheet_like_response.g.dart';

@JsonSerializable()
class GetSheetLikeResponse extends Response<List<String>>{
  GetSheetLikeResponse(String code, String message, List<String> data) : super(code: code, message: message, data: data);
  factory GetSheetLikeResponse.fromJson(Map<String, dynamic> json) => _$GetSheetLikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetLikeResponseToJson(this);
}