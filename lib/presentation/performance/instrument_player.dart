import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

class InstrumentPlayer {
  final FlutterMidi _flutterMidi = FlutterMidi();

  InstrumentPlayer() {
    _prepare();
  }

  void playMidiNote(int midi) {
    _flutterMidi.playMidiNote(midi: midi);
  }

  void _prepare() async {
    ByteData byte = await rootBundle.load('assets/sf2/SpanishClassicalGuitar-20190618.sf2');
    _flutterMidi.prepare(sf2: byte);
  }
}