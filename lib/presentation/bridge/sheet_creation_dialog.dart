import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:the_baetles_chord_play/widget/molecule/EllipseToggleButton.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';

class SheetCreationDialog extends StatefulWidget {
  const SheetCreationDialog({Key? key}) : super(key: key);

  @override
  State<SheetCreationDialog> createState() => _SheetCreationDialogState();
}

class _SheetCreationDialogState extends State<SheetCreationDialog> {
  SheetCreationDialogViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    SheetCreationDialogViewModel viewModel =
        context.watch<SheetCreationDialogViewModel>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                "악보 세부 설정",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppFontFamilies.pretendard,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                scrollPadding: EdgeInsets.zero,
                onChanged: viewModel.onChangeTitle,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: viewModel.isTitleValid
                          ? AppColors.grayD2
                          : AppColors.redFF,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grayD2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 12,
                  ),
                  hintText: "악보 제목을 입력해주세요.",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFontFamilies.pretendard,
                    color: AppColors.grayD2,
                  ),
                  counterText: "",
                ),
                autocorrect: false,
                maxLines: 1,
                maxLength: 15,
                cursorColor: AppColors.black04,
                enableInteractiveSelection: false,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamilies.pretendard,
                  fontSize: 14,
                  color: viewModel.isTitleValid
                      ? AppColors.black04
                      : AppColors.redFF,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 44,
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: EllipseToggleButton(
                      text: "취소",
                      initState: false,
                      onPressed: (_) => viewModel.onCancel(),
                      textStyleOnActivated: TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textStyleOnInActivated: TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black04,
                        fontSize: 14,
                      ),
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: EllipseToggleButton(
                      text: "확인",
                      initState: true,
                      onPressed: (_) => viewModel.onComplete(),
                      textStyleOnActivated: TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textStyleOnInActivated: TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black04,
                        fontSize: 14,
                      ),
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _viewModel = context.watch<SheetCreationDialogViewModel>();
  }

  @override
  void dispose() {
    _viewModel?.reset();
    super.dispose();
  }
}
