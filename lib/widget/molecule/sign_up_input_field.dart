import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';
import 'package:the_baetles_chord_play/widget/atom/sign_up_text_style.dart';

class SignUpInputField extends StatefulWidget {
  final String _initText;
  final String _hint;
  final int? _maxLength;

  SignUpInputField(this._initText, this._hint, {int? maxLength}) : _maxLength = maxLength;


  @override
  State<StatefulWidget> createState() {
    return SignUpInputFieldState();
  }

}
class SignUpInputFieldState extends State<SignUpInputField> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();

    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget._hint,
        hintStyle: SignUpTextStyle.hintText,
        counterText: "",
      ),
      autocorrect: false,
      textAlign: TextAlign.center,
      style: viewModel.isNicknameValid ? SignUpTextStyle.inputText : SignUpTextStyle.wrongInputText,
      initialValue: widget._initText,
      maxLength: widget._maxLength,
      cursorColor: viewModel.isNicknameValid ? AppColors.blue4E : AppColors.redFF,
      enableInteractiveSelection: false,
      onChanged: (value) {
        viewModel.onChangeNickname(value);
      },
    );
  }
}
