import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/model/api/request/sheet/post_sheet_request.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

import '../../model/api/request/sheet/patch_sheet_request.dart';
import '../../model/api/response/sheet/delete_sheet_response.dart';
import '../../model/api/response/sheet/get_condition_sheet_response.dart';
import '../../model/api/response/sheet/get_sheet_data_response.dart';
import '../../model/api/response/sheet/get_sheet_response.dart';
import '../../model/api/response/sheet/post_sheet_response.dart';

part 'sheet_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/sheets")
abstract class SheetClient {
  // single ton
  factory SheetClient (Dio dio, {String baseUrl}) = _SheetClient;
  // This class must include fromJson and toJson Methods;
  @GET('')
  Future<GetConditionSheetResponse> getSheetsByVideoId(@Query('videoId') videoId);

  @GET('')
  Future<GetConditionSheetResponse> getSheetsByUserId();

  @GET('/{sheetId}')
  Future<GetSheetResponse> getSheet();

  @GET('/{sheetId}')
  Future<GetSheetDataResponse> getSheetData(@Path('sheetId') sheetId);

  @POST('')
  Future<PostSheetResponse> createSheetData(@Body() PostSheetRequest postSheetRequest);

  @DELETE('/{sheetId}')
  Future<DeleteSheetResponse> deleteSheetData(@Path('sheetId') sheetId);

  @PATCH('/{sheetId}')
  Future<PatchSheetRequest> patchSheet(@Body() PatchSheetRequest patchSheetRequest);

}