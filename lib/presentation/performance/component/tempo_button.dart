import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/toggle_button.dart';

import '../../../widget/atom/app_font_families.dart';

class TempoButton extends StatefulWidget {
  final Function(double newTempo)? onChangeTempo;
  final List<double> tempos;

  TempoButton({
    Key? key,
    this.onChangeTempo,
    this.tempos = const [1.0, 1.2, 1.4, 0.6, 0.8],
  }) : super(key: key);

  @override
  State<TempoButton> createState() => _TempoButtonState();
}

class _TempoButtonState extends State<TempoButton> {
  int _currentTempoIdx = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      isToggled: false,
      text: "tempo",
      icon: Text(
        "X ${widget.tempos[_currentTempoIdx]}",
        style: TextStyle(
          color: Colors.white,
          fontFamily: AppFontFamilies.montserrat,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      onClick: () {
        setState(() {
          _currentTempoIdx = (_currentTempoIdx + 1) % widget.tempos.length;
        });
        widget.onChangeTempo?.call(widget.tempos[_currentTempoIdx]);
      },
    );
  }
}
