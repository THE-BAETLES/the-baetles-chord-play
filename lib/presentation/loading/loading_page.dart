import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:the_baetles_chord_play/presentation/loading/loading_view_model.dart';

import '../../domain/model/video.dart';
import '../../domain/model/sheet_info.dart';
import '../../widget/atom/app_colors.dart';

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
        Navigator.of(context).pushReplacementNamed(
          "/performance-page",
          arguments: {
            "video": video,
            "sheetInfo": viewModel.sheetInfo,
            "sheetData": viewModel.sheetData,
          },
        );
        viewModel.reset();
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              left: 0,
              top: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_guitar.svg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    height: 25,
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
          ),
        ],
      ),
    );
  }
}
