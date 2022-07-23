import 'package:flutter/material.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight =  MediaQuery.of(context).viewPadding.top;

    return Stack(
      children: [
        SizedBox(
          height: 162 + statusBarHeight,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 134 + statusBarHeight,
          color: AppColors.blue4E,
        ),
        Positioned(
          left: 18,
          bottom: 70,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Hello,\n',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Soyou Kim',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 24
                )
              ),
            ]),
          ),
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
