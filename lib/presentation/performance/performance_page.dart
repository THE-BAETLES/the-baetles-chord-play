import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/beat_tile.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';

import '../../domain/model/sheet_music.dart';
import '../../widget/atom/app_colors.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 방향으로 고정함
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    //Video video = ModalRoute.of(context)!.settings.arguments as Video;
    SheetMusic sheetMusic =
    ModalRoute
        .of(context)!
        .settings
        .arguments as SheetMusic;

    PerformanceViewModel viewModel = context.watch<PerformanceViewModel>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: AppColors.black04,
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.grayF5,
      body: SafeArea(
        child: Stack(
          children: [
            _sheetView(context, viewModel),
            Positioned(
              bottom: 0,
              child: _controlBar(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _sheetView(BuildContext context, PerformanceViewModel viewModel) {
    return Builder(builder: (BuildContext context) {
      List<Widget> tiles = [];

      for (int i = 0; i < 26; ++i) {
        tiles.add(
          BeatTile(
            chord: viewModel.chords[i],
          ),
        );
      }

      tiles.add(BeatTile(chord: viewModel.a.toString()));

      return ListView(
        children: tiles,
      );
    });
  }

  Widget _controlBar(BuildContext context) {
    return Container(
      height: 62,
      width: MediaQuery.of(context).size.width,
      color: AppColors.gray34,
      child: Row(
        children: [
          Container(
            child: Text("control bar!"),
          )
        ],
      ),
    );
  }
}
