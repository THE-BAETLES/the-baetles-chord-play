import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:the_baetles_chord_play/domain/model/fingering.dart';
import 'package:the_baetles_chord_play/domain/model/chord.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import '../../domain/model/finger.dart';
import '../../domain/model/finger_position.dart';

class FingeringDataSource {
  static final FingeringDataSource _instance = FingeringDataSource._internal();

  late final List<Fingering> fingeringData;

  factory FingeringDataSource() {
    return FingeringDataSource._instance;
  }

  FingeringDataSource._internal() {
    _loadData();
  }

  Future<void> _loadData() async {
    final String input =
        await rootBundle.loadString("assets/data/refined-data.csv");
    final fields = await CsvToListConverter()
        .convert(input, fieldDelimiter: ",", eol: '\n');

    final List<Fingering> fingerings = [];

    for (int rowIdx = 1; rowIdx < fields.length; ++rowIdx) {
      // ignore first row

      final field = fields[rowIdx];

      final Chord chord;
      final List<FingerPosition> positions = [];

      // parse chord data
      {
        final root = Note.fromNoteName(field[1]);
        final Note? bass =
            field[3] == "none" ? null : Note.fromNoteName(field[3]);

        final triadTypeIdx =
            TriadType.values.indexWhere((e) => e.notation == field[2]);

        if (triadTypeIdx == -1) {
          continue;
        }

        final TriadType triad = TriadType.values[triadTypeIdx];

        chord = Chord(root, triad, bass);
      }

      // parse finger positions
      {
        final String positionsInString = field[4] as String;
        final List<String> positionsInListString = positionsInString
            .substring(2, positionsInString.length - 2)
            .split('), (');

        for (int stringIdx = 0;
            stringIdx < positionsInListString.length;
            ++stringIdx) {
          final splitString = positionsInListString[stringIdx].split(', ');

          final fret = int.parse(splitString[0]);

          final fingerNum = int.parse(splitString[1]);
          final Finger? finger =
              fingerNum < 1 ? null : Finger.values[fingerNum - 1];

          positions.add(FingerPosition(
            finger: finger,
            stringNumber: stringIdx + 1,
            fret: fret,
          ));
        }
      }

      fingerings.add(Fingering(
        chord: chord,
        positions: positions,
      ));
    }

    fingeringData = fingerings;
  }

  List<Fingering> getFingeringsOfChord(Chord chord) {
    final List<Fingering> fingeringsOfChord = [];

    for (final fingering in fingeringData) {
      if (fingering.chord == chord) {
        fingeringsOfChord.add(fingering);
      }
    }

    return fingeringsOfChord;
  }
}
