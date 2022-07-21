import 'package:flutter/cupertino.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/toggle_box.dart';

class RadioButtonList extends StatefulWidget {
  final List<String> _texts;
  final void Function(int)? onPressed;

  const RadioButtonList(this._texts, {Key? key, this.onPressed})
      : super(key: key);

  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  int _selectedItemOffset = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _wrapTexts(widget._texts, context),
    );
  }

  List<Widget> _wrapTexts(List<String> texts, BuildContext context) {
    List<Widget> result = [];

    for (int i = 0; i < texts.length; ++i) {
      ToggleBox item = ToggleBox(
        texts[i],
        onPressed: () {
          setState(() {
            if (_selectedItemOffset == i) {
              _selectedItemOffset = -1;
            } else {
              _selectedItemOffset = i;
            }
          });

          widget.onPressed?.call(_selectedItemOffset);
        },
      );

      item.setIsActivated(_selectedItemOffset == i);

      result.add(SizedBox(
        height: 62,
        width: MediaQuery.of(context).size.width,
        child: item,
      ));

      // divider 추가
      result.add(Container(
        height: 12,
      ));
    }

    return result;
  }
}
