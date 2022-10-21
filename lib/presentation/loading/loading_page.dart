import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/bridge_view_model.dart';

import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';

import '../../domain/model/video.dart';
import '../../domain/model/sheet_info.dart';
import '../../widget/atom/app_colors.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  Video? video;
  SheetInfo? sheetInfo;
  late LoadingViewModel _viewModel;
  late FlutterGifController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FlutterGifController(vsync: this);
    _viewModel = context.read<LoadingViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      video = arguments['video'] as Video;
      final Function() onCompleteLoading =
          arguments['onCompleteLoading'] as Function();

      LoadingViewModel viewModel = context.read<LoadingViewModel>();
      viewModel.loadSheet(video!.id, onCompleteLoading);

      viewModel.isComplete.addListener(_onComplete);
    });
  }

  @override
  Widget build(BuildContext context) {
    LoadingViewModel viewModel = context.watch<LoadingViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageList(context),
            Container(
              height: 40,
            ),
            Container(
              child: Text(
                "배틀즈 봇이 열심히 악보를 분석하는 중...${viewModel.progress}%",
              ),
            ),
            Container(
              height: 16,
            ),
            Container(
              width: 340,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.mainPointColor,
                  width: 1,
                ),
              ),
              child: FAProgressBar(
                currentValue: viewModel.progress,
                progressColor: AppColors.mainPointColor,
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                animatedDuration: Duration(milliseconds: 200),
                size: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override


  Widget _imageList(BuildContext context) {
    _controller.repeat(
        min: 0, max: 88, period: const Duration(milliseconds: 2000));

    return GifImage(
      width: 350,
      height: 80,
      controller: _controller,
      fit: BoxFit.fitWidth,
      image: AssetImage("assets/icons/ani_loading.gif"),
    );
  }

  @override
  void didChangeDependencies() {
    _viewModel = context.read<LoadingViewModel>();
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.isComplete.removeListener(_onComplete);

    super.dispose();
  }

  void _onComplete() {
    if (_viewModel.isComplete.value) {
      Navigator.of(context).pop();
      _viewModel.reset();
    }
  }
}
