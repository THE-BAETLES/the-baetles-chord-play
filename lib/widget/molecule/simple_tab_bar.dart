import 'package:flutter/material.dart';

import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';

class SimpleTabBar extends StatelessWidget {
  final List<Widget> tabs;

  SimpleTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      physics: BouncingScrollPhysics(),
      isScrollable: true,
      padding: EdgeInsets.symmetric(horizontal: 15),
      tabs: tabs,
      labelColor: AppColors.mainPointColor,
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: AppFontFamilies.pretendard,
      ),
      unselectedLabelColor: AppColors.gray80,
      unselectedLabelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: AppFontFamilies.pretendard,
      ),
      indicatorColor: AppColors.mainPointColor,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }
}
