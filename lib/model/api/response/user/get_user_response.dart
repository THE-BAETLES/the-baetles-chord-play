import 'package:json_annotation/json_annotation.dart';

import '../../../schema/user/user_schema.dart';
import '../response.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class GetUserResponse extends Response<UserSchema> {
  GetUserResponse(String code, String message, UserSchema data) : super(code : code, message: message, data: data);
  factory GetUserResponse.fromJson(Map<String, dynamic> json) => _$GetUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);
}