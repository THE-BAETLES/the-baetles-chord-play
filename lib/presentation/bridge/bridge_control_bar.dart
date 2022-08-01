import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/bridge_view_model.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/EllipseToggleButton.dart';

import '../../widget/atom/app_colors.dart';

class BridgeControlBar extends StatelessWidget {
  const BridgeControlBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeViewModel viewModel = context.watch<BridgeViewModel>();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow94,
            blurRadius: 6.0
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              SvgPicture.asset(
                "assets/icons/ic_folder.svg",
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
              Container(
                height: 1,
                width: 48,
              ),
              Text(
                "목록담기",
                style: TextStyle(
                  fontFamily: AppFontFamilies.notosanskr,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray80,
                ),
              ),
            ],
          ),
          Container(
            width: 12,
          ),
          Flexible(
            child: Container(
              height: 50,
              child: EllipseToggleButton(
                text: 'Play',
                initState: viewModel.isStartButtonActivated,
                onPressed: (bool isActivated) {
                  viewModel.onStartButtonClicked(context);
                },
                textStyleOnActivated: const TextStyle(
                  fontFamily: AppFontFamilies.notosanskr,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textStyleOnInActivated: const TextStyle(
                  fontFamily: AppFontFamilies.notosanskr,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray73,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
