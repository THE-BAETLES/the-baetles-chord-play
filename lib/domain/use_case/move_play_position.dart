import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

class SetPlayPosition {
  final ConductorInterface _conductor;

  SetPlayPosition(this._conductor);

  Future<void> call({
    required int position,
  }) async {
    _conductor.syncPlayPosition(positionInMillis: position);
  }
}
