import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/bridge/sheet_creation_dialog_view_model.dart';
import 'package:the_baetles_chord_play/widget/molecule/EllipseToggleButton.dart';

import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final Widget? body;
  final Function()? onClickConfirmButton;
  final Function()? onClickCancelButton;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.body,
    this.onClickConfirmButton,
    this.onClickCancelButton,
  }) : super(key: key);

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
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
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppFontFamilies.pretendard,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: widget.body,
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
                      onPressed: (_) => widget.onClickCancelButton?.call(),
                      textStyleOnActivated: const TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textStyleOnInActivated: const TextStyle(
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
                      onPressed: (_) => widget.onClickConfirmButton?.call(),
                      textStyleOnActivated: const TextStyle(
                        fontFamily: AppFontFamilies.pretendard,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textStyleOnInActivated: const TextStyle(
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
  void dispose() {
    super.dispose();
  }
}
