import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

import '../model/play_state.dart';

class AddConductorPositionListener {
  final ConductorInterface _conductor;

  AddConductorPositionListener(this._conductor);

  void call(Function(PlayState) callback) {
    _conductor.addCurrentPositionListener(callback);
  }
}