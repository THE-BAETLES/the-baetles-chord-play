import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';

import '../../domain/model/play_state.dart';
import '../../presentation/performance/sheet_state.dart';

abstract class PerformerInterface {
  Future<bool> syncPlayStateAndReady(PlayState playState);
  Future<void> cancel();
  Future<void> onAttachConductor(ConductorInterface conductor);
  Future<void> dispose();
}