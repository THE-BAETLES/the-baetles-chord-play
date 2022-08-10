import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../domain/model/chord.dart';

class BeatTile extends StatelessWidget {
  final Chord? chord;

  const BeatTile({
    Key? key,
    this.chord,
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
              chord != null ? (chord?.root.noteName)! : '',
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
