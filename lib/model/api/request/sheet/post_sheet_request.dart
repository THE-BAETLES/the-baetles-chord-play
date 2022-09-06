import 'package:json_annotation/json_annotation.dart';

part 'post_sheet_request.g.dart';

@JsonSerializable()
class PostSheetRequest {
  RequestSheetInfo requestSheetInfo;
  PostSheetRequest({required this.requestSheetInfo});

  factory PostSheetRequest.fromJson(Map<String, dynamic> json) => _$PostSheetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetRequestToJson(this);
}

@JsonSerializable()
class RequestSheetInfo {
  String videoId;
  String title;
  RequestSheetInfo({required this.videoId, required this.title});

  factory RequestSheetInfo.fromJson(Map<String, dynamic> json) => _$RequestSheetInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RequestSheetInfoToJson(this);
}