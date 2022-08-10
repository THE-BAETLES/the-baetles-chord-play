import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

class BeatTile extends StatelessWidget {
  final String chord;

  const BeatTile({
    Key? key,
    required this.chord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build - $chord");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 40,
          height: 40,
          color: Colors.white,
          child: Center(
            child: Text(
              chord,
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFontFamilies.pretendard,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
