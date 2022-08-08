import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';

import '../../domain/model/video.dart';
import '../../domain/model/sheet_info.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    Video video = arguments[0] as Video;
    SheetInfo sheetInfo = arguments[1] as SheetInfo;

    LoadingViewModel viewModel = context.watch<LoadingViewModel>();
    viewModel.loadSheet(context, video, sheetInfo);

    return Container(
      child: Text('로딩 ${viewModel.progress}%...'),
    );
  }
}
