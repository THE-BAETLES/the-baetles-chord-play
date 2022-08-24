import 'dart:developer';

class Note {
  static final _pitchNames = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
  // static final _pitchNames = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B'];

  final int keyNumber;

  // region constructors
  Note(this.keyNumber) {
    assert (1 <= keyNumber || keyNumber <= 88);
  }

  Note.fromNoteNumber(int noteNumber) : this(noteNumber - 20);

  Note.fromNoteName(String noteName) : this(tryConvertNoteNameToKeyNumber(noteName)!);
  // endregion


  // region getters
  String get noteName {
    return tryConvertKeyNumberToNoteName(keyNumber)!;
  }

  String get noteNameWithoutOctave {
    String nameWithOctave = noteName;
    return nameWithOctave.substring(0, nameWithOctave.length - 1);
  }

  int get noteNumber {
    return keyNumber + 20;
  }
  
  String get rootName {
    String noteNameTmp = noteName;
    return noteNameTmp.substring(0, noteNameTmp.length - 1);
  }

  int get rootNumber {
    return _pitchNames.indexOf(rootName);
  }
  // endregion


  static String? tryConvertKeyNumberToNoteName(int keyNumber) {
    if (keyNumber < 1 || 88 < keyNumber) {
      assert(false, "Chord Model: keyNumber should be in range [1,88]");
      return null;
    }

    int pitch = (keyNumber + 8) % 12;
    String pitchName = _pitchNames[pitch];
    int octave = ((keyNumber + 8) / 12).floor();

    return '$pitchName$octave';
  }


  static int? tryConvertNoteNameToKeyNumber(String noteName) {
    if (noteName.length < 2 || 3 < noteName.length) {
      // noteName은 알파벳 1개 혹은 2개 뒤에 옥타브를 나타내는 숫자가 붙은 3자리 문자열임
      log("Chord Model: unexpected note name");
      return null;
    }

    String pitchName = noteName.substring(0, noteName.length - 1);
    int pitchIndex = _pitchNames.indexOf(pitchName);

    if (pitchIndex == -1) {
      log('Chord Model: unexpected note name');
      return null;
    }

    int? octave = int.tryParse(noteName[noteName.length - 1]);

    if (octave == null) {
      return null;
    }

    return 12 * (octave - 1) + pitchIndex + 4;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          keyNumber == other.keyNumber;


  @override
  int get hashCode => keyNumber.hashCode;
}