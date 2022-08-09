import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_data_schema.dart';

part 'get_sheet_data_response.g.dart';
@JsonSerializable()
class GetSheetDataResponse extends Response<SheetDataSchema>{
  GetSheetDataResponse(String code, String message, SheetDataSchema data) : super(code: code, message: message, data: data);
  factory GetSheetDataResponse.fromJson(Map<String, dynamic> json) => _$GetSheetDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetDataResponseToJson(this);
}

