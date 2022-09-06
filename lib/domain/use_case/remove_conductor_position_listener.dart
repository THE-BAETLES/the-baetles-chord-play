import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

import '../model/play_option.dart';

class RemoveConductorPositionListener {
  final ConductorInterface _conductor;

  RemoveConductorPositionListener(this._conductor);

  void call(Function(int) callback) {
    _conductor.removeCurrentPositionListener(callback);
  }
}