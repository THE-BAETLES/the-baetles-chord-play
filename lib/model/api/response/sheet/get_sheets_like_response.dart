import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheets_like_response.g.dart';

@JsonSerializable()
class GetSheetsLikeResponse extends Response<List<SheetSchema>>{
  GetSheetsLikeResponse(String code, String message, List<SheetSchema> data) : super(code: code, message: message, data: data);
  factory GetSheetsLikeResponse.fromJson(Map<String, dynamic> json) => _$GetSheetsLikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetsLikeResponseToJson(this);
}