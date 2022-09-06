import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/domain/model/chord.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

void main() {
  group('Note model test', () {
    test('Instance construction', () {
      Note note1 = Note(10);
      expect(note1.keyNumber, 10);
      expect(note1.noteNumber, 30);
      expect(note1.noteName, 'F#1');
      expect(note1.rootName, "F#");
      expect(note1.rootNumber, 6);

      Note note2 = Note(1);
      expect(note2.keyNumber, 1);
      expect(note2.noteNumber, 21);
      expect(note2.noteName, 'A0');
      expect(note2.rootName, "A");
      expect(note2.rootNumber, 9);

      Note note3 = Note(88);
      expect(note3.keyNumber, 88);
      expect(note3.noteNumber, 108);
      expect(note3.noteName, 'C8');
      expect(note3.rootName, "C");
      expect(note3.rootNumber, 0);

      Note note4 = Note.fromNoteName('D6');
      expect(note4.keyNumber, 66);
      expect(note4.noteNumber, 86);
      expect(note4.noteName, 'D6');
      expect(note4.rootName, "D");
      expect(note4.rootNumber, 2);

      Note note5 = Note.fromNoteName('F2');
      expect(note5.keyNumber, 21);
      expect(note5.noteNumber, 41);
      expect(note5.noteName, 'F2');
      expect(note5.rootName, "F");
      expect(note5.rootNumber, 5);

      Note note6 = Note.fromNoteName('D#4');
      expect(note6.keyNumber, 43);
      expect(note6.noteNumber, 63);
      expect(note6.noteName, 'D#4');
      expect(note6.rootName, "D#");
      expect(note6.rootNumber, 3);

      Note note10 = Note.fromNoteName('A0');
      expect(note10.keyNumber, 1);
      expect(note10.noteNumber, 21);
      expect(note10.noteName, 'A0');
      expect(note10.rootName, 'A');
      expect(note10.rootNumber, 9);

      Note note7 = Note.fromNoteNumber(56);
      expect(note7.keyNumber, 36);
      expect(note7.noteNumber, 56);
      expect(note7.noteName, 'G#3');
      expect(note7.rootName, "G#");
      expect(note7.rootNumber, 8);

      Note note8 = Note.fromNoteNumber(70);
      expect(note8.keyNumber, 50);
      expect(note8.noteNumber, 70);
      expect(note8.noteName, 'A#4');
      expect(note8.rootName, "A#");
      expect(note8.rootNumber, 10);

      Note note9 = Note.fromNoteNumber(65);
      expect(note9.keyNumber, 45);
      expect(note9.noteNumber, 65);
      expect(note9.noteName, 'F4');
      expect(note9.rootName, "F");
      expect(note9.rootNumber, 5);

      print("Note model test complete");
    });
  });

  group('Chord model test', () {
    test('Instance construction', () {
      Chord chord1 = Chord(Note.fromNoteName("D#4"), TriadType.major);
      expect(chord1.chordName, "D#maj");

      Chord chord2 = Chord(Note.fromNoteName("C2"), TriadType.minor);
      expect(chord2.chordName, "Cmin");

      Chord chord3 = Chord(Note.fromNoteName("G#3"), TriadType.diminished);
      expect(chord3.chordName, "G#dim");

      Chord chord4 = Chord(Note.fromNoteName("A#0"), TriadType.augmented);
      expect(chord4.chordName, "A#aug");

      Chord chord5 = Chord.fromString("D#4:maj");
      expect(chord1, chord5);

      Chord chord6 = Chord.fromString("C2:min");
      expect(chord2, chord6);

      Chord chord7 = Chord.fromString("G#3:dim");
      expect(chord3, chord7);

      Chord chord8 = Chord.fromString("A#0:aug");
      expect(chord4, chord8);

      print("Chord model test complete");
    });
  });

  // group('ChordBlock model test', () {
  //   test('json to instance', () {
//       String json =
//       """{
//   "bpm": 120,
//   "chord_infos": [
//     {
//       "chord": "F#:maj",
//       "end": 13.560453428,
//       "position": 25,
//       "start": 12.213696067
//     },
//     {
//       "chord": "G#:maj",
//       "end": 14.489251608,
//       "position": 28,
//       "start": 13.606893337
//     },
//     {
//       "chord": "A#:maj",
//       "end": 16.997006694,
//       "position": 30,
//       "start": 14.535691517
//     },
//     {
//       "chord": "F#:maj",
//       "end": 18.11156451,
//       "position": 35,
//       "start": 17.043446603
//     },
//     {
//       "chord": "G#:maj",
//       "end": 18.993922781,
//       "position": 37,
//       "start": 18.158004419
//     },
//     {
//       "chord": "A#:maj",
//       "end": 21.548117776,
//       "position": 39,
//       "start": 19.04036269
//     },
//   ],
// }""";
//
//
//   });
}