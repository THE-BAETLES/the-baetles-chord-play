import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/radio_button_list.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/video_radio_button_list.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/sign_up_view_model.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_guide.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_input_field.dart';
import 'package:the_baetles_chord_play/widget/molecule/sign_up_next_button.dart';

import '../../domain/model/gender.dart';
import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';

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
                  child: SignUpInputField(
                    viewModel.inputNickname,
                    "닉네임을 입력해주세요.",
                    maxLength: 15,
                  ),
                ),
                Visibility(
                  visible: viewModel.isNicknameConfirmButtonVisible,
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
                  child: SignUpGuide(
                      "${viewModel.confirmedNickname}님의\n성별은 어떻게되나요?"),
                ),
                Positioned(
                  left: 30,
                  top: 288,
                  height: 200,
                  width: MediaQuery.of(context).size.width - 60,
                  child: RadioButtonList(
                    const ["남성입니다", "여성입니다"],
                    onPressed: (int index) {
                      if (index == -1) {
                        viewModel.onChangeGender(null);
                      } else {
                        viewModel.onChangeGender(Gender.values[index]);
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: viewModel.isGenderConfirmButtonVisible,
                  child: Positioned(
                    bottom: 0,
                    child: SignUpNextButton(() async {
                      viewModel.onConfirmGender();
                      animatePage(viewModel.pageOffset);
                    }),
                  ),
                ),
              ],
            ),

            // 세 번째 페이지 : 실력 입력 페이지
            Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 60,
                  child: SignUpGuide(
                      "${viewModel.confirmedNickname}님의\n실력을 알려주세요!"),
                ),
                Positioned(
                  left: 30,
                  top: 251,
                  height: 250,
                  width: MediaQuery.of(context).size.width - 60,
                  child: RadioButtonList(
                    const ["초보입니다", "중수입니다", "고수입니다"],
                    onPressed: (int offset) {
                      switch (offset) {
                        case -1:
                          viewModel.onChangeGrade(null);
                          break;
                        case 0:
                          viewModel.onChangeGrade(PerformerGrade.beginner);
                          break;
                        case 1:
                          viewModel.onChangeGrade(PerformerGrade.intermediate);
                          break;
                        case 2:
                          viewModel.onChangeGrade(PerformerGrade.expert);
                          break;
                        default:
                          if (kDebugMode) {
                            print("SignUpPage: undefined offset");
                          }
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: viewModel.isGradeConfirmButtonVisible,
                  child: Positioned(
                    bottom: 0,
                    child: SignUpNextButton(() async {
                      viewModel.onConfirmGrade();
                      animatePage(viewModel.pageOffset);
                    }),
                  ),
                ),
              ],
            ),

            // 네 번째 페이지 : 선호하는 곡 입력 페이지
            Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 30,
                  child: SignUpGuide(
                      "${viewModel.confirmedNickname}님이\n즐겨듣는 노래를 선택해주세요 :)"),
                ),
                Positioned(
                  top: 180,
                  left: 30,
                  width: MediaQuery.of(context).size.width - 60,
                  child: VideoRadioButtonList(
                    videos: viewModel.musicToCheckPreference,
                    onChange: (Video video, bool isActivated) {
                      viewModel.onChangePreferredSong(video, isActivated);
                    },
                  ),
                ),
                Visibility(
                  visible: viewModel.isPreferenceConfirmButtonVisible,
                  child: Positioned(
                    bottom: 0,
                    child: SignUpNextButton(() async {
                      bool isSuccessful =
                          await viewModel.onCompleteButtonClicked();

                      if (isSuccessful) {
                        await viewModel.onConfirmPreferredSong();
                        animatePage(viewModel.pageOffset);
                      } else {
                        Fluttertoast.showToast(
                          msg: "회원가입 도중 오류가 발생했습니다. 다시 시도해주세요.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),

            // 다섯 번째 페이지 : 회원가입 완료 페이지
            Stack(
              children: [
                Positioned(
                  top: 238,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 0,
                        width: MediaQuery.of(context).size.width,
                      ),
                      // SvgPicture.asset(
                      //   "assets/icons/ic_emoji_thumb.svg",
                      //   width: 80,
                      //   height: 80,
                      // ),
                      Image.asset(
                        "assets/icons/ic_thumb_up.png",
                      ),
                      Container(height: 30),
                      Text(
                        '환영해요, ${viewModel.confirmedNickname}님\n회원가입이 완료되었어요!',
                        style: const TextStyle(
                          fontFamily: AppFontFamilies.pretendard,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(height: 15),
                      const Text(
                        '악보를 만들고, 공유하며 경험치를 쌓아보세요',
                        style: TextStyle(
                          fontFamily: AppFontFamilies.pretendard,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SignUpNextButton(() async {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('home-page', (route) => false);
                  }),
                ),
              ],
            )
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
