import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/viewmodels/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/widgets/atoms/sign_up_text_style.dart';
import 'package:the_baetles_chord_play/widgets/molecules/sign_up_guide.dart';
import 'package:the_baetles_chord_play/widgets/molecules/sign_up_input_field.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignUpViewModel viewModel = context.watch<SignUpViewModel>()

    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Scaffold(
        appBar: null,
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                left: 30,
                top: 60,
                child: SignUpGuide("사용하실 닉네임을\n설정해주세요 :)"),
              ),

              Positioned(
                left: 10,
                top: 260,
                height: 30,
                width: MediaQuery.of(context).size.width - 20,
                child: Container(
                  child: SignUpInputField("악보총총이", "닉네임을 입력해주세요.", maxLength: 15, validator: (value) {
                    if (value == null || value.length <= 2) {
                      return "길이가 너무 짧습니다.";
                    }

                    return null;
                  }),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
