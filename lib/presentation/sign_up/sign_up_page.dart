import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_guide.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_input_field.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_next_button.dart';

class SignUpPage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // 첫 번째 페이지 :닉네임 설정 페이지
            Stack(
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
                  child:
                      SignUpInputField("악보총총이", "닉네임을 입력해주세요.", maxLength: 15),
                ),
                Visibility(
                  visible: viewModel.isNextButtonVisible,
                  child: Positioned(
                    bottom: 0,
                    child: SignUpNextButton(() async {
                      final String? message = await viewModel
                          .onConfirmNickname(viewModel.inputNickname);

                      // 오류 메시지 출력
                      if (message != null) {
                        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      } else {
                        animatePage(viewModel.pageOffset);
                      }
                    }),
                  ),
                ),
              ],
            ),

            // 두 번째 페이지 : 성별 입력 페이지
            Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 60,
                  child: SignUpGuide("${viewModel.confirmedNickname}님의\n성별은 어떻게되나요?"),
                ),
                Positioned(
                  left: 10,
                  top: 260,
                  height: 30,
                  width: MediaQuery.of(context).size.width - 20,
                  child:
                      SignUpInputField("악보총총이", "성별을 입력해주세요.", maxLength: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void animatePage(int offset) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        offset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
