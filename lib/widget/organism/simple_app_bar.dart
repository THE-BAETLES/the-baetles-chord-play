import 'package:flutter/material.dart';

import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';

class SimpleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double dividerHeight;

  const SimpleAppBar({
    Key? key,
    required this.title,
    this.dividerHeight = 1.5,
  }) : super(key: key);

  @override
  State<SimpleAppBar> createState() => _SimpleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SimpleAppBarState extends State<SimpleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(widget.dividerHeight),
        child: Container(
          color: AppColors.grayE3,
          height: widget.dividerHeight,
        ),
      ),
      elevation: 0,
      title: Text(widget.title),
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: AppColors.black04,
        fontFamily: AppFontFamilies.pretendard,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
