import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

class AddPerformer {
  final ConductorInterface _conductorService;

  AddPerformer(this._conductorService);

  Future<void> call(final PerformerInterface performer) async {
    _conductorService.addPerformer(performer);
  }
}