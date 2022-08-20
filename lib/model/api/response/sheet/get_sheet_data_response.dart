import 'package:the_baetles_chord_play/domain/model/sheet_info.dart';
import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_data_schema.dart';

import '../../../../domain/model/sheet_data.dart';

part 'get_sheet_data_response.g.dart';
@JsonSerializable()
class GetSheetDataResponse extends Response<SheetDataSchema>{
  GetSheetDataResponse(String code, String message, SheetDataSchema data) : super(code: code, message: message, data: data);
  factory GetSheetDataResponse.fromJson(Map<String, dynamic> json) => _$GetSheetDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetDataResponseToJson(this);

  SheetData toSheetData() {
    return data!.toSheetData();
  }
}

