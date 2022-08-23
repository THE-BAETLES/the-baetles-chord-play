// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SheetClient implements SheetClient {
  _SheetClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/sheets';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetConditionSheetResponse> getSheetsByVideoId(videoId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'videoId': videoId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetConditionSheetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetConditionSheetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetConditionSheetResponse> getSheetsByUserId() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetConditionSheetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetConditionSheetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetSheetResponse> getSheet() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSheetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets/{sheetId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSheetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetSheetDataResponse> getSheetData(sheetId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSheetDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets/${sheetId}/data',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSheetDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostSheetResponse> postSheet(postSheetRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postSheetRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostSheetResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostSheetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostSheetDataResponse> postSheetData(postSheetDataRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(postSheetDataRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostSheetDataResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets/data',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostSheetDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteSheetResponse> deleteSheetData(sheetId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteSheetResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sheets/${sheetId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteSheetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PatchSheetResponse> patchSheet(sheetId, patchSheetRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(patchSheetRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PatchSheetResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/${sheetId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PatchSheetResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
