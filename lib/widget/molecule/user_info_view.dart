import 'package:flutter/material.dart';

class UserInfoView extends StatelessWidget {
  late final String userNickname;
  late final String userProfileImagePath;

  UserInfoView({
    Key? key,
    required this.userNickname,
    required this.userProfileImagePath,
  }) : super(key: key);

  UserInfoView.fromUserId({
    Key? key,
    required String userid,
  }) : super(key: key) {
    this.userNickname = "";
    this.userProfileImagePath = "";

    Future(() async {
      // dummy data
      this.userNickname = "dummy";
      this.userProfileImagePath =
          "https://avatars.githubusercontent.com/u/40628765?v=4";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            userProfileImagePath,
            width: 20,
            height: 20,
            fit: BoxFit.cover,
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
