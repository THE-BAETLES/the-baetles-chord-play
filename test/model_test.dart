import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/domain/model/chord.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

void main() {
  group('Note Model Test', () {
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
    });
  });
}