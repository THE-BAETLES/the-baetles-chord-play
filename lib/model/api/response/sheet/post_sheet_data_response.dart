import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/response/response.dart';

part 'post_sheet_data_response.g.dart';

@JsonSerializable()
class PostSheetDataResponse extends Response<String> {
  PostSheetDataResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory PostSheetDataResponse.fromJson(Map<String, dynamic> json) => _$PostSheetDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetDataResponseToJson(this);
}