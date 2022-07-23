import 'package:flutter/material.dart';

class TransparentAppbar extends AppBar {
  TransparentAppbar({Key? key})
      : super(
          key: key,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 58,
        );
}
