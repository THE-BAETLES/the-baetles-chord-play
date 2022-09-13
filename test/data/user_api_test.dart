import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:the_baetles_chord_play/data/source/remote_data_source.dart';

import 'user_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  group("닉네임 추천 api", () {
    test("getNicknameSuggestion_validToken_returnsSuggestedNickname", () async {
      String fakeToken = "tokennn";
      String fakeJson = """
{
    "code": "200",
    "message": "success",
    "data": {
        "nickname": "abc111"
    }
}
""";

      final client = MockClient();

      when(client.get(
          Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
          headers: {
            RemoteDataSource.idTokenKey:
                '${RemoteDataSource.bearer} ${fakeToken}'
          })).thenAnswer((_) async => http.Response(fakeJson, 200));

      final source = RemoteDataSource();
      final result =
          await source.getNicknameSuggestion(fakeToken, client: client);

      expect(result, "abc111");

      verify(client.get(
          Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
          headers: {
            RemoteDataSource.idTokenKey:
                '${RemoteDataSource.bearer} ${fakeToken}'
          }));
    });

    test("getNicknameSuggestion_invalidToken_returnNull", () async {
      String fakeToken = "invalidToken";
      String fakeJson = """
{
    "message": "INVALID_HEADER"
}
""";

      final client = MockClient();

      when(client.get(
          Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
          headers: {
            RemoteDataSource.idTokenKey:
                '${RemoteDataSource.bearer} ${fakeToken}'
          })).thenAnswer((_) async => http.Response(fakeJson, 400));

      final source = RemoteDataSource();
      final result =
          await source.getNicknameSuggestion(fakeToken, client: client);

      expect(result, isNull);

      verify(client.get(
          Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
          headers: {
            RemoteDataSource.idTokenKey:
                '${RemoteDataSource.bearer} ${fakeToken}'
          }));
    });
  });
}
