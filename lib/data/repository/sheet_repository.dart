import 'dart:collection';

import 'package:the_baetles_chord_play/model/api/response/sheet/get_condition_sheet_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_sheet_data_response.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../router/sheet/sheet_client.dart';

class SheetRepository {
  static final SheetRepository _instance = SheetRepository._internal();

  factory SheetRepository() {
    return _instance;
  }

  SheetRepository._internal();

  Future<Map<String, List<SheetInfo>>> fetchSheetsByVideoId(
      String videoId) async {
    SheetClient client = RestClientFactory().getClient(
        RestClientType.sheet) as SheetClient;
    GetConditionSheetResponse response = (await client.getSheetsByVideoId(
        videoId));
    Map<String, List<SheetInfo>> sheets = response.data!.toMap();

    return sheets;
  }

  Future<SheetData> fetchSheetDataBySheetId(String sheetId) async {
    SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;
    GetSheetDataResponse response = await client.getSheetData(sheetId);
    SheetData sheetData = response.toSheetData();
    return sheetData;
  }
}
