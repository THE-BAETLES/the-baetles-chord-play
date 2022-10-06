import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_duplication_response.g.dart';

@JsonSerializable()
class PostSheetDuplicationResponse extends Response<String> {
  PostSheetDuplicationResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory PostSheetDuplicationResponse.fromJson(Map<String, dynamic> json) => _$PostSheetDuplicationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetDuplicationResponseToJson(this);
}

