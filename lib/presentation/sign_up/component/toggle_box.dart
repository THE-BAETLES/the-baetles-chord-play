import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/atom/sign_up_text_style.dart';

import '../../../widget/atom/app_colors.dart';

class ToggleBox extends StatefulWidget {
  final String _text;
  late final void Function()? _onPressed;

  bool _isActivated = false;

  bool get isActivated => _isActivated;

  ToggleBox(this._text, {Key? key, void Function()? onPressed})
      : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  State<ToggleBox> createState() {
    return _ToggleBoxState();
  }

  void setIsActivated(bool isActivated) {
    _isActivated = isActivated;
  }
}

class _ToggleBoxState extends State<ToggleBox> {
  @override
  Widget build(BuildContext context) {
    if (widget._isActivated) {
      // 선택되었을 때의 ui
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            widget._onPressed?.call();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            surfaceTintColor: AppColors.whiteEF,
            side: const BorderSide(
              width: 2,
              color: AppColors.blue4E,
            ),
            shadowColor: AppColors.shadowB5,
          ),
          child: Stack(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              // ),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget._text,
                    style: const TextStyle(
                      color: AppColors.blue4E,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFontFamilies.pretendard,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 19,
                height: 24,
                width: 24,
                child: SvgPicture.asset('assets/icons/ic_check1.svg'),
              ),
            ],
          ),
        ),
      );
    } else {
      // 선택되지 않았을 때의 ui
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            widget._onPressed?.call();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: AppColors.shadowB5,
          ),
          child: Text(
            widget._text,
            style: const TextStyle(
              color: AppColors.black04,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamilies.pretendard,
            ),
          ),
        ),
      );
    }
  }
}
