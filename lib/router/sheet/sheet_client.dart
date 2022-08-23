import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/model/api/request/sheet/post_sheet_data_request.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/patch_sheet_response.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';
import 'package:the_baetles_chord_play/router/client.dart';

import '../../model/api/request/sheet/patch_sheet_request.dart';
import '../../model/api/request/sheet/post_sheet_request.dart';
import '../../model/api/response/sheet/delete_sheet_response.dart';
import '../../model/api/response/sheet/get_condition_sheet_response.dart';
import '../../model/api/response/sheet/get_sheet_data_response.dart';
import '../../model/api/response/sheet/get_sheet_response.dart';
import '../../model/api/response/sheet/post_sheet_data_response.dart';
import '../../model/api/response/sheet/post_sheet_response.dart';

part 'sheet_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/sheets")
abstract class SheetClient extends RestClient{
  // single ton
  factory SheetClient (Dio dio, {String baseUrl}) = _SheetClient;
  // This class must include fromJson and toJson Methods;
  @GET('/sheets')
  Future<GetConditionSheetResponse> getSheetsByVideoId(@Query('videoId') String videoId);

  @GET('/sheets')
  Future<GetConditionSheetResponse> getSheetsByUserId();

  @GET('/sheets/ai')
  Future<GetSheetDataResponse> getAISheet();

  @GET('/sheets/{sheetId}')
  Future<GetSheetResponse> getSheet();

  @GET('/sheets/{sheetId}/data')
  Future<GetSheetDataResponse> getSheetData(@Path('sheetId') sheetId);

  @POST('/sheets')
  Future<PostSheetResponse> postSheet(@Body() PostSheetRequest postSheetRequest);

  @POST('/sheets/data')
  Future<PostSheetDataResponse> postSheetData(@Body() PostSheetDataRequest postSheetDataRequest);

  @DELETE('/sheets/{sheetId}')
  Future<DeleteSheetResponse> deleteSheetData(@Path('sheetId') String sheetId);

  @PATCH('/{sheetId}')
  Future<PatchSheetResponse> patchSheet(@Path('sheetId') String sheetId, @Body() PatchSheetRequest patchSheetRequest);

}