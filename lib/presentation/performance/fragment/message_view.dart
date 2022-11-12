import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_colors.dart';

class MessageView extends StatefulWidget {
  final List<Widget> messages;

  const MessageView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> messageWidgets = [];

    for (final message in widget.messages) {
      messageWidgets.add(Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: EdgeInsets.all(10),
        child: message,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(offset: Offset(0, 3), color: AppColors.shadow94, blurRadius: 3),
          ],
        ),
      ));
    }

    return Container(
      child: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: messageWidgets,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }
}
