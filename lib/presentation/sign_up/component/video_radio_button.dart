import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/check_icon.dart';

import '../../../widget/atom/app_colors.dart';

class VideoRadioButton extends StatefulWidget {
  final String _imagePath;
  final String _title;
  final void Function(bool) _onChangeActivative;

  const VideoRadioButton(this._imagePath, this._title, this._onChangeActivative,
      {Key? key})
      : super(key: key);

  @override
  State<VideoRadioButton> createState() => _VideoRadioButtonState();
}

class _VideoRadioButtonState extends State<VideoRadioButton> {
  bool _isActivated = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isActivated = !_isActivated;
            });

            widget._onChangeActivative(_isActivated);
          },
          child: SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _isActivated ? AppColors.blue4E : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(46),
                      child:
                          Image.network(widget._imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  left: 66,
                  top: 3,
                  child: Visibility(
                    visible: _isActivated,
                    child: const CheckIcon(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
    height: 0,
    ),
        SizedBox(
          height: 15,
          child: Text(
            widget._title,
            style: const TextStyle(fontSize: 11, color: AppColors.gray80),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
