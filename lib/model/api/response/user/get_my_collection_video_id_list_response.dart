import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_my_collection_video_id_list_response.g.dart';

@JsonSerializable()
class GetMyCollectionVideoIdListResponse extends Response<List<String>> {
  GetMyCollectionVideoIdListResponse(String code, String message, List<String> data) : super(code: code, message: message, data: data);
  factory GetMyCollectionVideoIdListResponse.fromJson(Map<String, dynamic> json) => _$GetMyCollectionVideoIdListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyCollectionVideoIdListResponseToJson(this);
}