import 'package:flutter/material.dart';

import '../atom/app_colors.dart';

class SignUpNextButton extends StatelessWidget {
  final void Function() _onPressed;

  const SignUpNextButton(this._onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          primary: AppColors.blue4E,
        ),
        child: const Text(
          '다음',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          _onPressed();
        },
      ),
    );
  }
}
