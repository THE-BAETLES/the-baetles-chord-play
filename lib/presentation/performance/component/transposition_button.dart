import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/app_text_styles.dart';

class TranspositionButton extends StatefulWidget {
  final Function(int)? onChangeIntercept;
  final int minIntercept;
  final int maxIntercept;

  const TranspositionButton({
    Key? key,
    this.onChangeIntercept,
    this.minIntercept = -11,
    this.maxIntercept = 11,
  }) : super(key: key);

  @override
  State<TranspositionButton> createState() => _TranspositionButtonState();
}

class _TranspositionButtonState extends State<TranspositionButton> {
  int _intercept = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.gray3E,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _changeIntercept(_intercept - 1);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_minus.svg",
                        color: AppColors.servePointColor2,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 43,
                    alignment: Alignment.center,
                    child: Text(
                      _intercept.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "Key",
                    style: AppTextStyles.controlButtonTextStyle.copyWith(
                      color: AppColors.gray9B,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _changeIntercept(_intercept + 1);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_plus.svg",
                        color: AppColors.servePointColor2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeIntercept(int newIntercept) {
    if (widget.minIntercept <= newIntercept &&
        newIntercept <= widget.maxIntercept) {
      setState(() {
        _intercept = newIntercept;
      });
      widget.onChangeIntercept?.call(newIntercept);
    }
  }
}
