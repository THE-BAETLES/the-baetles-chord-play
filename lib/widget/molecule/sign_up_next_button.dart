import 'package:flutter/material.dart';

class SignUpNextButton extends StatelessWidget {
  final void Function() _onPressed;

  const SignUpNextButton(this._onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero)),
        child: Text('다음'),
        onPressed: () {
          _onPressed();
        },
      ),
    );
  }
}