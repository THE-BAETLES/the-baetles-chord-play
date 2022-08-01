import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/model/sheet_music.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 방향으로 고정함
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    //Video video = ModalRoute.of(context)!.settings.arguments as Video;
    SheetMusic sheetMusic = ModalRoute.of(context)!.settings.arguments as SheetMusic;

    return Container(child: Text("${sheetMusic.title}"),);
  }
}
