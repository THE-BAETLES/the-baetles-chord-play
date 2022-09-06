import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

class MovePlayPosition {
  final ConductorInterface _conductor;

  MovePlayPosition(this._conductor);

  Future<void> call({
    required int position,
  }) async {
    _conductor.syncPlayPosition(positionInMillis: position);
  }
}
