import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'delete_sheet_like_response.g.dart';

@JsonSerializable()
class DeleteSheetLikeResponse extends Response<String>{
  DeleteSheetLikeResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory DeleteSheetLikeResponse.fromJson(Map<String, dynamic> json) => _$DeleteSheetLikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteSheetLikeResponseToJson(this);
}