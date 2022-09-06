import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

import '../../domain/model/play_option.dart';
import '../../presentation/performance/sheet_state.dart';

abstract class PerformerInterface {
  Future<bool> syncPlayOptionAndReady(PlayOption playOption);
  Future<void> cancel();
  Future<void> onAttachConductor(ConductorInterface conductor);
  Future<void> dispose();
}