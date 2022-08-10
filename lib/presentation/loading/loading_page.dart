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
            "sheetInfo": sheetInfo,
            "sheetData": SheetData(bpm: 30, chords: [
              ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 25, 12.213696067, 13.560453428),
              ChordBlock(Chord(Note.fromNoteName('G#3'), TriadType.major), 28, 13.606893337, 14.489251608),
              ChordBlock(Chord(Note.fromNoteName('A#3'), TriadType.major), 30, 14.535691517, 16.997006694),
              ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 35, 17.043446603, 18.11156451),
              ChordBlock(Chord(Note.fromNoteName('F#3'), TriadType.major), 300, 17.043446603, 18.11156451),
            ]),
          },
        );
      });
    }

    return Scaffold(
      body: Container(
        child: Text('로딩 ${video?.title} ${viewModel.progress}%...'),
      ),
    );
  }

  @override
  void dispose() {
    context.read<LoadingViewModel>().onDispose();
    super.dispose();
  }
}
