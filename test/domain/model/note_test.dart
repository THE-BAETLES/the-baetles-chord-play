import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';

void main() {
  group('Note model test', () {
    test('givenValidKeyNumber_whenGetter_thenConvertValueProperly', () {
      Note note1 = Note(10);

      expect(note1.keyNumber, 10);
      expect(note1.noteNumber, 30);
      expect(note1.rootName, "F#");
      expect(note1.rootNumber, 6);
      expect(note1.hasKeySignature, true);
      expect(note1.keySignature, '♭');

      expect(note1.noteName, 'F#1');
      expect(note1.noteNameWithoutOctave, 'F#');
      expect(note1.noteNameWithoutOctaveAndKeySignature, 'F');
      expect(note1.flatNoteName, 'G♭1');
      expect(note1.flatNoteNameWithoutOctave, 'G♭');
      expect(note1.flatNoteNameWithoutOctaveAndKeySignature, 'G');


      Note note2 = Note(1);

      expect(note2.keyNumber, 1);
      expect(note2.noteNumber, 21);
      expect(note2.rootName, "A");
      expect(note2.rootNumber, 9);
      expect(note2.hasKeySignature, false);
      expect(note2.keySignature, '');

      expect(note2.noteName, 'A0');
      expect(note2.noteNameWithoutOctave, 'A');
      expect(note2.noteNameWithoutOctaveAndKeySignature, 'A');
      expect(note2.flatNoteName, 'A0');
      expect(note2.flatNoteNameWithoutOctave, 'A');
      expect(note2.flatNoteNameWithoutOctaveAndKeySignature, 'A');


      Note note3 = Note(88);

      expect(note3.keyNumber, 88);
      expect(note3.noteNumber, 108);
      expect(note3.rootName, "C");
      expect(note3.rootNumber, 0);

      expect(note3.noteName, 'C8');
      expect(note3.noteNameWithoutOctave, 'C');
      expect(note3.noteNameWithoutOctaveAndKeySignature, 'C');
      expect(note3.flatNoteName, 'C8');
      expect(note3.flatNoteNameWithoutOctave, 'C');
      expect(note3.flatNoteNameWithoutOctaveAndKeySignature, 'C');


      Note note4 = Note.fromNoteName('D6');

      expect(note4.keyNumber, 66);
      expect(note4.noteNumber, 86);
      expect(note4.rootName, "D");
      expect(note4.rootNumber, 2);

      expect(note4.noteName, 'D6');
      expect(note4.noteNameWithoutOctave, 'D');
      expect(note4.noteNameWithoutOctaveAndKeySignature, 'D');
      expect(note4.flatNoteName, 'D6');
      expect(note4.flatNoteNameWithoutOctave, 'D');
      expect(note4.flatNoteNameWithoutOctaveAndKeySignature, 'D');


      Note note5 = Note.fromNoteName('F2');

      expect(note5.keyNumber, 21);
      expect(note5.noteNumber, 41);
      expect(note5.rootName, "F");
      expect(note5.rootNumber, 5);

      expect(note5.noteName, 'F2');
      expect(note5.noteNameWithoutOctave, 'F');
      expect(note5.noteNameWithoutOctaveAndKeySignature, 'F');
      expect(note5.flatNoteName, 'F2');
      expect(note5.flatNoteNameWithoutOctave, 'F');
      expect(note5.flatNoteNameWithoutOctaveAndKeySignature, 'F');


      Note note6 = Note.fromNoteName('D#4');

      expect(note6.keyNumber, 43);
      expect(note6.noteNumber, 63);
      expect(note6.rootName, "D#");
      expect(note6.rootNumber, 3);

      expect(note6.noteName, 'D#4');
      expect(note6.noteNameWithoutOctave, 'D#');
      expect(note6.noteNameWithoutOctaveAndKeySignature, 'D');
      expect(note6.flatNoteName, 'E♭4');
      expect(note6.flatNoteNameWithoutOctave, 'E♭');
      expect(note6.flatNoteNameWithoutOctaveAndKeySignature, 'E');


      Note note10 = Note.fromNoteName('A0');

      expect(note10.keyNumber, 1);
      expect(note10.noteNumber, 21);
      expect(note10.rootName, 'A');
      expect(note10.rootNumber, 9);

      expect(note10.noteName, 'A0');
      expect(note10.noteNameWithoutOctave, 'A');
      expect(note10.noteNameWithoutOctaveAndKeySignature, 'A');
      expect(note10.flatNoteName, 'A0');
      expect(note10.flatNoteNameWithoutOctave, 'A');
      expect(note10.flatNoteNameWithoutOctaveAndKeySignature, 'A');


      Note note7 = Note.fromNoteNumber(56);

      expect(note7.keyNumber, 36);
      expect(note7.noteNumber, 56);
      expect(note7.rootName, "G#");
      expect(note7.rootNumber, 8);

      expect(note7.noteName, 'G#3');
      expect(note7.noteNameWithoutOctave, 'G#');
      expect(note7.noteNameWithoutOctaveAndKeySignature, 'G');
      expect(note7.flatNoteName, 'A♭3');
      expect(note7.flatNoteNameWithoutOctave, 'A♭');
      expect(note7.flatNoteNameWithoutOctaveAndKeySignature, 'A');


      Note note8 = Note.fromNoteNumber(70);

      expect(note8.keyNumber, 50);
      expect(note8.noteNumber, 70);
      expect(note8.rootName, "A#");
      expect(note8.rootNumber, 10);

      expect(note8.noteName, 'A#4');
      expect(note8.noteNameWithoutOctave, 'A#');
      expect(note8.noteNameWithoutOctaveAndKeySignature, 'A');
      expect(note8.flatNoteName, 'B♭4');
      expect(note8.flatNoteNameWithoutOctave, 'B♭');
      expect(note8.flatNoteNameWithoutOctaveAndKeySignature, 'B');


      Note note9 = Note.fromNoteNumber(65);

      expect(note9.keyNumber, 45);
      expect(note9.noteNumber, 65);
      expect(note9.rootName, "F");
      expect(note9.rootNumber, 5);

      expect(note9.noteName, 'F4');
      expect(note9.noteNameWithoutOctave, 'F');
      expect(note9.noteNameWithoutOctaveAndKeySignature, 'F');
      expect(note9.flatNoteName, 'F4');
      expect(note9.flatNoteNameWithoutOctave, 'F');
      expect(note9.flatNoteNameWithoutOctaveAndKeySignature, 'F');

      log("Note model test complete");
    });

    test("givenInvalidParameter_whenConstructNote_thenReturnNull", () {
      // todo
    });
  });
}