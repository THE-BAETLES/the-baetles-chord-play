import 'package:flutter/material.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/atom/search_icon.dart';
import '../../widget/molecule/search_bar.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Stack(
      children: [
        SizedBox(
          height: 162 + statusBarHeight,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 134 + statusBarHeight,
          color: AppColors.mainPointColor,
        ),
        Positioned(
          left: 18,
          bottom: 70,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: '안녕하세요,\n',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: "$userName",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
              TextSpan(
                text: '님!',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
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
            child: _searchBar(context),
          ),
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/sheet-page"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow94,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SearchIcon(
                        width: 17,
                        height: 17,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: "악보영상을 검색해보세요!",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFontFamilies.pretendard,
                      fontWeight: FontWeight.w300,
                      color: AppColors.gray9D,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
