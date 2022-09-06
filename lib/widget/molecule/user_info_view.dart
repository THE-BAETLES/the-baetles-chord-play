import 'package:flutter/material.dart';

class UserInfoView extends StatelessWidget {
  late final String userNickname;
  late final Widget userProfileImage;

  UserInfoView({
    Key? key,
    required this.userNickname,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 20,
            height: 20,
            child: userProfileImage,
          ),
        ),
        Container(
          width: 6,
        ),
        Text(userNickname),
      ],
    );
  }
}
