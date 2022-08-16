import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

class CallPerformer implements PerformerInterface{
  Function(PlayState)? callback;

  void setCallback(Function(PlayState) callback) {
    this.callback = callback;
  }

  @override
  Future<void> cancel() {
    // TODO: implement cancle
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> onAttachConductor(ConductorInterface conductor) async {
    // nothing
    return;
  }

  @override
  Future<bool> syncPlayStateAndReady(PlayState playState) async {
    callback?.call(playState);
    return true;
  }
  
}