import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/request/request.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_data_schema.dart';

part 'post_sheet_data_request.g.dart';

@JsonSerializable()
class PostSheetDataRequest extends Request{
    SheetDataSchema sheetData;
    RequestSheetInfo sheet;

    PostSheetDataRequest({required this.sheetData, required this.sheet});

    factory PostSheetDataRequest.fromJson(Map<String, dynamic> json) => _$PostSheetDataRequestFromJson(json);
    Map<String, dynamic> toJson() => _$PostSheetDataRequestToJson(this);
}

@JsonSerializable()
class RequestSheetInfo {
    String videoId;
    String title;
    RequestSheetInfo({required this.videoId, required this.title});

    factory RequestSheetInfo.fromJson(Map<String, dynamic> json) => _$RequestSheetInfoFromJson(json);
    Map<String, dynamic> toJson() => _$RequestSheetInfoToJson(this);
}