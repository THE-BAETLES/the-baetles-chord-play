import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_response.g.dart';

@JsonSerializable()
class PostSheetResponse extends Response<int>{
  PostSheetResponse(String code, String message, int data) : super(code: code, message: message, data: data);
  factory PostSheetResponse.fromJson(Map<String, dynamic> json) => _$PostSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetResponseToJson(this);
}

