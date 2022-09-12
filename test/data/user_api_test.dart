import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:the_baetles_chord_play/data/source/remote_data_source.dart';

import 'user_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {

  test("/v1/user/nickname", () async {
    String fakeToken = "tokennn";
    String fakeJson = """
{
    "code": "200",
    "message": "success",
    "data": {
        "nickname": "chj7239"
    }
}
""";

    final client = MockClient();

    when(client.get(
      Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
      headers: {RemoteDataSource.idTokenKey: '${RemoteDataSource.bearer} ${fakeToken}'}
    ))
    .thenAnswer((_) async => http.Response(fakeJson, 200));

    final source = RemoteDataSource();
    final result = await source.getNicknameSuggestion(fakeToken, client: client);

    expect(result, "chj7239");

    verify(
        client.get(
            Uri.parse('${RemoteDataSource.httpUriHead}/user/nickname'),
            headers: {RemoteDataSource.idTokenKey: '${RemoteDataSource.bearer} ${fakeToken}'}
        )
    );
  });
  
}

