import 'package:flutter/material.dart';

import '../../../domain/model/chord.dart';

class BeatState {
  final Chord? chord;
  final bool isPlaying;

  BeatState(this.chord, this.isPlaying);
}