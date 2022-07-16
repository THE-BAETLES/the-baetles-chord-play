import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widgets/atoms/sign_up_text_style.dart';

class SignUpGuide extends StatelessWidget {
  final String _text;

  const SignUpGuide(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: SignUpTextStyle.h1,
    );
  }
}