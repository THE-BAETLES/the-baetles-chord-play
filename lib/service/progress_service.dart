import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ProgressService {
  static final ProgressService _progressService = ProgressService._internal();
  final baseUrl = dotenv.env['API_BASE_URL']!;
  late String idToken;

  factory ProgressService() {
    return _progressService;
  }

  ProgressService._internal() {
    (() async {
      idToken = (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    })();
    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user != null) {
        idToken = await user.getIdToken();
      }
    });
  }

  void start(String videoId, void Function(SSEModel event)? onData, void Function()? onDone) {
    //Get sheets
    SSEClient.subscribeToSSE(url: "$baseUrl/sheets/ai/$videoId", header: {
      'Authorization': "Bearer $idToken",
      "Accept": "text/event-stream",
      "Cache-Control": "no-cache",
    }).listen(onData).onDone(onDone);
  }

  stop() {
    SSEClient.unsubscribeFromSSE();
  }
}