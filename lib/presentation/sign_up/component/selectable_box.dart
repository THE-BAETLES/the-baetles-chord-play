import 'package:flutter/material.dart';

class SelectableBox extends StatefulWidget {
  final String _text;
  late final void Function()? _onPressed;

  SelectableBox(this._text, {Key? key, void Function()? onPressed}) : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  State<SelectableBox> createState() {
    return _SelectableBoxState();
  }
}

class _SelectableBoxState extends State<SelectableBox> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget._onPressed?.call();
      },
      child: Text(widget._text),
    );
  }
}