import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/icons/ic_check1.svg");
  }
}
