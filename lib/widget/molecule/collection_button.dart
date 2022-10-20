import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_baetles_chord_play/presentation/performance/component/toggle_button.dart';

class CollectionButton extends StatelessWidget {
  final double width;
  final double height;
  final bool isIncluded;

  CollectionButton({
    Key? key,
    required this.width,
    required this.height,
    required this.isIncluded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: SvgPicture.asset(
        isIncluded
            ? "assets/icons/ic_folder_minus.svg"
            : "assets/icons/ic_folder_plus.svg",
        width: width,
        height: height,
      ),
    );
  }
}
