import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/atom/google_icon.dart';

import '../atom/search_icon.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Container(
        height: 18,
        child: const TextField(
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          maxLength: 100,
          autocorrect: false,
          enableInteractiveSelection: false,
          cursorColor: AppColors.black04,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            counterText: '',
            prefixIcon: SearchIcon(width: 16, height: 16),
            hintText: '악보영상을 검색해보세요!',
            hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: AppFontFamilies.pretendard,
              fontWeight: FontWeight.w300,
            ),
          ),
          style: TextStyle(
            fontFamily: AppFontFamilies.pretendard,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: AppColors.black04,
          ),
        ),
      ),
    );
  }
}
