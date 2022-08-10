import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/toggle_box.dart';

class RadioButtonList extends StatefulWidget {
  static const int none = -1;

  final List<String> _texts;
  final void Function(int)? onPressed;

  const RadioButtonList(this._texts, {Key? key, this.onPressed})
      : super(key: key);

  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  int _selectedItemIndex = RadioButtonList.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _wrapTexts(widget._texts, context),
    );
  }

  List<Widget> _wrapTexts(List<String> texts, BuildContext context) {
    List<Widget> wrappedTexts = [];

    for (int i = 0; i < texts.length; ++i) {
      ToggleBox item = ToggleBox(
        texts[i],
        onPressed: () {
          setState(() {
            if (_selectedItemIndex == i) {
              _selectedItemIndex = -1; // 활성화된 토글 버튼 없음
            } else {
              _selectedItemIndex = i;
            }
          });

          widget.onPressed?.call(_selectedItemIndex);
        },
      );

      item.setIsActivated(_selectedItemIndex == i);  // 토글 상태 반영

      // item 추가
      wrappedTexts.add(SizedBox(
        height: 62,
        width: MediaQuery.of(context).size.width,
        child: item,
      ));

      // divider 추가
      wrappedTexts.add(Container(
        height: 12,
      ));
    }

    return wrappedTexts;
  }
}
