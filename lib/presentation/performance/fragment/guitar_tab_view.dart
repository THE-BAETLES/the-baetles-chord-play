import 'package:flutter/material.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';

import '../../../widget/atom/app_colors.dart';
import '../../../widget/atom/chord_text.dart';

class GuitarTabView extends StatelessWidget {
  static const double topMargin = 62.0;
  static const double bottomMargin = 105.0;

  final double width;
  final double height;

  const GuitarTabView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: topMargin),
            _tabView(root: "D", postfix: "m", tab: 'x 0 0 2 3 1', size: 8),
            _tabView(root: "D", postfix: "m", tab: 'x 0 0 2 3 1', size: 5),
            _tabView(root: "D", postfix: "m", tab: 'x 0 0 2 3 1', size: 5),
            _tabView(root: "D", postfix: "m", tab: 'x 0 0 2 3 1', size: 5),
            _tabView(root: "D", postfix: "m", tab: 'x 0 0 2 3 1', size: 5),
            const SizedBox(height: bottomMargin),
          ],
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  Widget _tabView({
    required String root,
    required String postfix,
    required String tab,
    required int size,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 50,
              alignment: Alignment.center,
              child: ChordText(
                root: root,
                postfix: postfix,
                rootColor: AppColors.black04,
                postfixColor: AppColors.black04,
              )),
          Expanded(
            child: Container(
              child: FlutterGuitarTab(
                tab: tab,
                size: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
