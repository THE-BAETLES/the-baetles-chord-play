import 'package:flutter/material.dart';

import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import '../atom/app_colors.dart';

class EllipseToggleButton extends StatefulWidget {
  final String text;
  final void Function(bool isActivated) onPressed;
  final bool initState;
  final TextStyle textStyleOnActivated;
  final TextStyle textStyleOnInActivated;
  final BorderRadius borderRadius;
  final bool autoToggle;

  EllipseToggleButton({
    Key? key,
    required this.text,
    required this.initState,
    required this.onPressed,
    required this.textStyleOnActivated,
    required this.textStyleOnInActivated,
    required this.borderRadius,
    this.autoToggle = true,
  }) : super(key: key);

  @override
  State<EllipseToggleButton> createState() => _EllipseToggleButtonState();
}

class _EllipseToggleButtonState extends State<EllipseToggleButton> {
  late bool _isActivated = widget.initState;

  @override
  Widget build(BuildContext context) {
    _isActivated = widget.initState;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: ElevatedButton(
          onPressed: () {
            if (widget.autoToggle) {
              setState(() {
                _isActivated = !_isActivated;
              });
            }

            widget.onPressed(_isActivated);
          },
          style: ElevatedButton.styleFrom(
            primary: _isActivated ? AppColors.mainPointColor : Colors.white,
            side: BorderSide(
              color: _isActivated ? AppColors.mainPointColor : AppColors.grayD2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius,
            ),
            enableFeedback: false,
            elevation: 0,
          ),
          child: Text(
            widget.text,
            style: _isActivated
                ? widget.textStyleOnActivated
                : widget.textStyleOnInActivated,
          ),
        ),
      );
    });
  }
}
