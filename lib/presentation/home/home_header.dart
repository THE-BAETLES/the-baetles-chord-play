import 'package:flutter/material.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 162,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 134,
          color: AppColors.blue4E,
        ),
        Positioned(
          left: 0,
          top: 112,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: SearchBar(),
          ),
        ),
      ],
    );
  }
}
