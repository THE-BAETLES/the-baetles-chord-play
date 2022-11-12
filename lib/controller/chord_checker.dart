import 'dart:developer';

import 'package:the_baetles_chord_play/data/source/fingering_data_source.dart';
import 'package:the_baetles_chord_play/controller/pitch_checker.dart';
import 'package:the_baetles_chord_play/domain/model/finger_position.dart';
import 'package:tuple/tuple.dart';

import '../domain/model/chord.dart';
import '../domain/model/fingering.dart';

class ChordChecker {
  final pitchChecker = PitchChecker();
  final fingeringData = FingeringDataSource();

  void start() {
    pitchChecker.start();
  }

  void pause() {
    pitchChecker.pause();
  }

  /// [start]로부터 [length] 밀리초 동안 [chord]가 감지되었는지 검사합니다.
  ///
  /// [chord]가 감지되었을 경우에는 반환되는 튜플의 첫 번째 원소로 true를 전달하며 감지된 운지법을 함께 전달합니다.
  /// [chord]가 감지되지 않은 경우에는 반환되는 튜플의 첫 번째 원소로 false를 전달하며 가장 근접한 운지법을 전달합니다.
  /// [chord]에 해당하는 운지법 데이터가 없는 경우에는 반환되는 튜플의 첫 번째 원소로 false를 전달하며 두 번째 원소로 null을 전달합니다.
  Tuple3<bool, Fingering?, List<int>> isChordExist(int start, int length, Chord chord) {
    final fingerings = fingeringData.getFingeringsOfChord(chord);
    Fingering? nearestFingering;
    List<int> nearestWrongStrings = [];

    for (final fingering in fingerings) {
      List<FingerPosition> detected = [];
      List<FingerPosition> notDetected = [];

      int maxCorrect = -1;

      // log("check chord ${chord.fullName}... ${start} to ${start + length}, ${fingering.positions}");

      for (final finger in fingering.positions) {
        bool isExist = pitchChecker.isPitchExist(start, length, finger.note.keyNumber);

        if (isExist) {
          detected.add(finger);
        } else {
          notDetected.add(finger);
        }
      }

      if (notDetected.isEmpty) {
        return Tuple3(true, fingering, []);
      }

      if (maxCorrect < detected.length) {
        maxCorrect = detected.length;
        nearestFingering = fingering;
        nearestWrongStrings = [];

        for (FingerPosition position in notDetected) {
          nearestWrongStrings.add(position.stringNumber);
        }
      }
    }

    return Tuple3(false, nearestFingering, nearestWrongStrings);
  }
}