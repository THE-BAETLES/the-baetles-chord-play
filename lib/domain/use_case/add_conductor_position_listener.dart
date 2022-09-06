import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

import '../model/play_option.dart';

class AddConductorPositionListener {
  final ConductorInterface _conductor;

  AddConductorPositionListener(this._conductor);

  void call(Function(int) callback) {
    _conductor.addCurrentPositionListener(callback);
  }
}