import 'package:flutter/cupertino.dart';

abstract class ScaleAdapter {

  void onScaleStart(ScaleStartDetails scaleStartDetails);

  void onScaleUpdate(ScaleUpdateDetails scaleUpdateDetails);

  void onScaleEnd(ScaleEndDetails scaleEndDetails);
}
