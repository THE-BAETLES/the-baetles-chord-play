import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/domain/model/chord.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('Chord model test', () {
    test('givenValidNoteAndTriadAndBass_whenConstructChordFromString_thenConstructProperly', () {
      // (input, (root answer, triad answer, bass answer))
      final List<Tuple2<String, Tuple3<Note, TriadType, Note?>>> testCases = [
        Tuple2("E5:maj", Tuple3(Note.fromNoteName("E5"), TriadType.major, null)),
        Tuple2("E5:7:", Tuple3(Note.fromNoteName("E5"), TriadType.seven, null)),
        Tuple2("C#3:dim", Tuple3(Note.fromNoteName("C#3"), TriadType.diminished, null)),
        Tuple2("C#3:dim:", Tuple3(Note.fromNoteName("C#3"), TriadType.diminished, null)),
        Tuple2("C#3:dim:A0", Tuple3(Note.fromNoteName("C#3"), TriadType.diminished, Note.fromNoteName("A0"))),
        Tuple2("A0:none", Tuple3(Note.fromNoteName("A0"), TriadType.none, null)),
        Tuple2("A0:none:", Tuple3(Note.fromNoteName("A0"), TriadType.none, null)),
        Tuple2("A0:none:A0", Tuple3(Note.fromNoteName("A0"), TriadType.none, Note.fromNoteName("A0"))),
      ];

      for (Tuple2<String, Tuple3<Note, TriadType, Note?>> testCase in testCases) {
        String input = testCase.item1;
        Tuple3<Note, TriadType, Note?> answer = testCase.item2;

        Chord chord = Chord.fromString(input);
        expect(chord.root, answer.item1);
        expect(chord.triadType, answer.item2);
        expect(chord.bass, answer.item3);
      }
    });


    test('givenValidNoteAndTriadAndBass_whenConstructChord_thenConstructProperly', () {
      {
        Chord chord1 = Chord(Note.fromNoteName("D#4"), TriadType.major, null);
        expect(chord1.chordName, "D#maj");

        Chord chord2 = Chord(Note.fromNoteName("C2"), TriadType.minor, null);
        expect(chord2.chordName, "Cmin");

        Chord chord3 = Chord(
            Note.fromNoteName("G#3"), TriadType.diminished, null);
        expect(chord3.chordName, "G#dim");

        Chord chord4 = Chord(
            Note.fromNoteName("A#0"), TriadType.augmented, null);
        expect(chord4.chordName, "A#aug");

        Chord chord5 = Chord.fromString("D#4:maj");
        expect(chord1, chord5);

        Chord chord6 = Chord.fromString("C2:min");
        expect(chord2, chord6);

        Chord chord7 = Chord.fromString("G#3:dim");
        expect(chord3, chord7);

        Chord chord8 = Chord.fromString("A#0:aug");
        expect(chord4, chord8);
      }

      {
        Chord chord = Chord(Note.fromNoteName("D3"), TriadType.major, Note.fromNoteName("E2"));
        expect(chord.fullName, "D3:maj:E2");
      }

      {
        Chord chord = Chord(Note.fromNoteName("F#4"), TriadType.addNine, Note.fromNoteName("D#3"));
        expect(chord.fullName, "F#4:add9:D#3");
      }

      {
        Chord chord = Chord(Note.fromNoteName("A#7"), TriadType.majorSevenSharpEleven, Note.fromNoteName("C3"));
        expect(chord.fullName, "A#7:maj7(#11):C3");
      }

      {
        Chord chord = Chord(Note.fromNoteName("C1"), TriadType.none, Note.fromNoteName("A0"));
        expect(chord.fullName, "C1:none:A0");
      }
    });

    test("givenInvalidParameter_whenConstructChord_thenReturnNull", () {

    });

    test("givenEqualChords_whenCompareEqual_thenReturnTrue", () {
      final List<Tuple2<Chord, Chord>> testCases = [
        Tuple2(Chord.fromString("C#4:maj"), Chord.fromString("C#4:maj")),
        Tuple2(Chord.fromString("A0:min"), Chord.fromString("A0:min:")),
        Tuple2(Chord.fromString("E3:maj7"), Chord.fromString("E3:maj7")),
      ];

      for (Tuple2<Chord, Chord> testCase in testCases) {
        Chord chord1 = testCase.item1;
        Chord chord2 = testCase.item2;
        expect(chord1 == chord2, true);
      }
    });

    test("givenDifferentChords_whenCompareEqual_thenReturnTrue", () {
      final List<Tuple2<Chord, Chord>> testCases = [
        Tuple2(Chord.fromString("C#4:maj"), Chord.fromString("C#3:maj")),
        Tuple2(Chord.fromString("A0:min"), Chord.fromString("D5:min:")),
        Tuple2(Chord.fromString("E3:maj7:A0"), Chord.fromString("E3:maj7")),
        Tuple2(Chord.fromString("E2:maj7:A0"), Chord.fromString("C#2:maj7:A0")),
        Tuple2(Chord.fromString("E2:min:A0"), Chord.fromString("E2:min7:A0")),
        Tuple2(Chord.fromString("D2:none:A0"), Chord.fromString("D2:maj:A0")),
        Tuple2(Chord.fromString("G#6:dim:"), Chord.fromString("G#6:dim:C#3")),
      ];

      for (Tuple2<Chord, Chord> testCase in testCases) {
        Chord chord1 = testCase.item1;
        Chord chord2 = testCase.item2;
        expect(chord1 == chord2, false);
      }
    });
  });
}