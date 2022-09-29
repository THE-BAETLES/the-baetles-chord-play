import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/presentation/performance/performance_view_model.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';

class PerformanceAppBar extends StatelessWidget {
  final PerformanceViewModel viewModel;
  final double height;

  const PerformanceAppBar({
    Key? key,
    required this.viewModel,
    this.height = 52,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _appBar(
      viewModel: viewModel,
      height: height,
    );
  }

  Widget _appBar({
    required PerformanceViewModel viewModel,
    double? height = 52,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  BackButton(),
                ],
              ),
            ),
            Text(
              viewModel.sheetState.value?.sheetInfo.title ?? "",
              style: const TextStyle(
                color: AppColors.black04,
                fontFamily: AppFontFamilies.notosanskr,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 22,
                    height: 20.52,
                    child: SvgPicture.asset(
                      "assets/icons/ic_empty_heart.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: 16,
                  ),
                  Container(
                    width: 28,
                    height: 29,
                    child: SvgPicture.asset(
                      "assets/icons/ic_expansion.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
