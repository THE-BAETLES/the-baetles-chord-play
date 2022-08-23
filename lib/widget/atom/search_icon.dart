import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SearchIcon extends StatelessWidget {
  final double width;
  final double height;

  const SearchIcon({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/ic_search.svg",
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
