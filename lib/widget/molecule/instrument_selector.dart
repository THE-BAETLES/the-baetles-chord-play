import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../atom/app_colors.dart';
import '../atom/app_font_families.dart';
import 'EllipseToggleButton.dart';

class InstrumentSelector extends StatefulWidget {
  static const int none = -1;

  final List<String> instruments;
  final void Function(int) onSelected;

  const InstrumentSelector({
    Key? key,
    required this.instruments,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<InstrumentSelector> createState() => _InstrumentSelectorState();
}

class _InstrumentSelectorState extends State<InstrumentSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    // 라디오 버튼 리스트 구성
    buttons.add(makeButton(widget.instruments[0], 0 == _selectedIndex, 0));

    for (int i = 1; i < widget.instruments.length; ++i) {
      buttons.add(Container(width: 10)); // space
      buttons.add(makeButton(widget.instruments[i], i == _selectedIndex, i));
    }

    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: buttons),
    );
  }

  Widget makeButton(String instrument, bool initState, int index) {
    return Flexible(
      child: SizedBox(
        height: 36,
        child: EllipseToggleButton(
          text: instrument,
          initState: initState,
          textStyleOnActivated: const TextStyle(
            fontFamily: AppFontFamilies.pretendard,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          textStyleOnInActivated: const TextStyle(
            fontFamily: AppFontFamilies.pretendard,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.gray73,
          ),
          onPressed: (bool isActivated) {
            if (!isActivated) {
              setState(() {
                _selectedIndex = InstrumentSelector.none;
              });
              widget.onSelected(_selectedIndex);
            } else if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSelected(_selectedIndex);
            }
          },
          borderRadius: BorderRadius.circular(23),
        ),
      ),
    );
  }
}
