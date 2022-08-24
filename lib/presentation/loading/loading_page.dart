import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/chord_block.dart';
import '../../domain/model/note.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/triad_type.dart';
import '../../domain/model/video.dart';
import '../../domain/model/sheet_info.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Video? video;
  SheetInfo? sheetInfo;
  late LoadingViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      video = arguments['video'] as Video;
      sheetInfo = arguments['sheetInfo'] as SheetInfo;

      LoadingViewModel viewModel = context.read<LoadingViewModel>();
      viewModel.loadSheet(video!, sheetInfo!);
    });

    _viewModel = context.read<LoadingViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    LoadingViewModel viewModel = context.watch<LoadingViewModel>();
    if (viewModel.isLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popAndPushNamed(
          "/performance-page",
          arguments: {
            "video": video,
            "sheetInfo": viewModel.sheetInfo,
            "sheetData": viewModel.sheetData,
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    value: viewModel.progress / 100.0,
                    semanticsLabel: 'Linear progress indicator',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _viewModel = context.read<LoadingViewModel>();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
  }
}
