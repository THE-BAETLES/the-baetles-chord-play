import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:the_baetles_chord_play/service/progress_service.dart';

import '../../domain/use_case/get_sheet_data.dart';

class LoadingViewModel extends ChangeNotifier {
  static const onCompleteDownload = "1";
  static const onCompleteExtraction = "2";
  static const onCompleteGeneration = "3";

  double _progress = 0;
  bool _isComplete = false;

  Function()? _onCompleteLoading;

  double get progress => _progress;

  bool get isLoaded => progress == 100;

  bool get isComplete => _isComplete;

  LoadingViewModel();

  void loadSheet(String videoId, Function() onCompleteLoading) async {
    _setAndNotifyProgressValue(1);
    _onCompleteLoading = onCompleteLoading;
    _setAndNotifyProgressValue(10);

    ProgressService().start(videoId, _onProgressHandler, _sseDoneHandler);
  }

  void reset() {
    _isComplete = false;
    _progress = 0;
  }

  void _setAndNotifyProgressValue(double value) {
    _progress = value;
    notifyListeners();
  }

  void _onProgressHandler(SSEModel event) {
    String? status = event.data?.trim();
    log("SSE progress event listen - status : $status");

    if (status == onCompleteDownload) {
      _setAndNotifyProgressValue(50);
    } else if (status == onCompleteExtraction) {
      _setAndNotifyProgressValue(70);
    } else if (status == onCompleteGeneration) {
      _setAndNotifyProgressValue(90);

      (() async {
        _setAndNotifyProgressValue(100);
        Timer(Duration(milliseconds: 200), () {
          _isComplete = true;
          notifyListeners();
          _onCompleteLoading!.call();
        });
      })();
    }
  }

  void _sseDoneHandler() async {
    log("SSE done");
  }
}
