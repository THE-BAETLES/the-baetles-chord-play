import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ProgressService {
  static final ProgressService _progressService = ProgressService._internal();
  // final baseUrl = dotenv.env['API_BASE_URL']!;
  final baseUrl = "https://api.baetles.site/v1";
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
    if (kDebugMode) {
      print("sse progress service start with { videoId: ${videoId}, onData: ${onData.toString()}, onDone: ${onDone.toString()}}");
    }
    //Get sheets
    SSEClient.subscribeToSSE(url: "$baseUrl/sheets/ai/$videoId", header: {
      'Authorization': "Bearer $idToken",
      "Accept": "text/event-stream",
      "Cache-Control": "no-cache",
      "Connection": "keep-alive",
      "Keep-Alive": "timeout=300, max=2000",
    }).listen(onData).onDone(onDone);
  }

  void stop() {
    SSEClient.unsubscribeFromSSE();
    if (kDebugMode) {
      print("sse stopped");
    }
  }
}