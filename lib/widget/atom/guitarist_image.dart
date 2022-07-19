import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GuitaristImage extends StatelessWidget {
  const GuitaristImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/img_guitarist.svg');
  }
}