import '../../domain/model/play_state.dart';
import '../../presentation/performance/sheet_state.dart';

abstract class PerformerInterface {
  Future<bool> syncPlayStateAndReady(PlayState playState);
  Future<void> execute();
  Future<void> dispose();
}