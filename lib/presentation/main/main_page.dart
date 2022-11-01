import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../collection/collection_page.dart';
import '../home/home_page.dart';
import '../sheet/sheet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    HomePage(),
    CollectionPage(),
    SheetPage(),
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[pageIndex],
      bottomNavigationBar: _mainPageNavigationBar(
        selectedItemIndex: pageIndex,
        onTap: (int index) {
          if (index < 0 || pages.length <= index) {
            return;
          }
          
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }

  Widget _mainPageNavigationBar({
    required final Function(int) onTap,
    required final int selectedItemIndex,
  }) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowA1,
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedItemIndex,
          selectedLabelStyle: const TextStyle(
            fontSize: 9,
            color: AppColors.mainPointColor,
            fontWeight: FontWeight.w600,
            fontFamily: AppFontFamilies.pretendard,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 9,
            color: AppColors.gray9D,
            fontWeight: FontWeight.w400,
            fontFamily: AppFontFamilies.pretendard,
          ),
          selectedItemColor: AppColors.mainPointColor,
          unselectedItemColor: AppColors.gray9D,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_home.svg",
                  color: AppColors.gray9D,
                  fit: BoxFit.cover,
                ),
              ),
              activeIcon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_home.svg",
                  color: AppColors.mainPointColor,
                  fit: BoxFit.cover,
                ),
              ),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_folder.svg",
                  fit: BoxFit.cover,
                ),
              ),
              activeIcon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_folder.svg",
                  color: AppColors.mainPointColor,
                  fit: BoxFit.cover,
                ),
              ),
              label: "내 곡 목록",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_music_file.svg",
                  fit: BoxFit.cover,
                ),
              ),
              activeIcon: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icons/ic_music_file.svg",
                  color: AppColors.mainPointColor,
                  fit: BoxFit.cover,
                ),
              ),
              label: "악보",
            ),
            // BottomNavigationBarItem(
            //   icon: Container(
            //     width: 32,
            //     height: 32,
            //     padding: EdgeInsets.all(5),
            //     child: SvgPicture.asset(
            //       "assets/icons/ic_record1.svg",
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   activeIcon: Container(
            //     width: 32,
            //     height: 32,
            //     padding: EdgeInsets.all(5),
            //     child: SvgPicture.asset(
            //       "assets/icons/ic_record1.svg",
            //       color: AppColors.mainPointColor,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   label: "레코드",
            // ),
          ],
        ),
      ),
    );
  }
}
