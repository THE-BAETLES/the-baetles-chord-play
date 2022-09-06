import 'package:the_baetles_chord_play/domain/model/play_option.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

class PlayOptionCallbackPerformer implements PerformerInterface {
  Function(PlayOption)? callback;

  void setCallback(Function(PlayOption) callback) {
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
  Future<bool> syncPlayOptionAndReady(PlayOption playOption) async {
    callback?.call(playOption);
    return true;
  }
  
}