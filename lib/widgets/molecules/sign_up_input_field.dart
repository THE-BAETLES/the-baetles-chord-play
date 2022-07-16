import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:the_baetles_chord_play/widgets/atoms/app_colors.dart';
import 'package:the_baetles_chord_play/widgets/atoms/sign_up_text_style.dart';

class SignUpInputField extends StatefulWidget {
  final String _initText;
  final String _hint;
  final int? _maxLength;
  final String? Function(String?)? _validator;
  bool _isValid = true;

  SignUpInputField(this._initText, this._hint,
      {int? maxLength, String? Function(String?)? validator})
      : _maxLength = maxLength,
        _validator = validator;


  @override
  State<StatefulWidget> createState() {
    return SignUpInputFieldState();
  }

}
class SignUpInputFieldState extends State<SignUpInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget._hint,
        hintStyle: SignUpTextStyle.hintText,
        counterText: "",
      ),
      autocorrect: false,
      textAlign: TextAlign.center,
      style: widget._isValid ? SignUpTextStyle.inputText : SignUpTextStyle.wrongInputText,
      initialValue: widget._initText,
      maxLength: widget._maxLength,
      cursorColor: widget._isValid ? AppColors.blue4E : AppColors.redFF,
      enableInteractiveSelection: false,
      onChanged: (value) {
        final String? problem = widget._validator?.call(value);
        final validChars = RegExp(r"^[가-힣0-9a-zA-Z_]+$");
        final result = (value != null && problem == null && validChars.hasMatch(value));

        SchedulerBinding.instance.addPostFrameCallback((timestamp) {
          if (widget._isValid != result) {
            setState(() {
              widget._isValid = result;
            });
          }
        });
      },
    );
  }
}
