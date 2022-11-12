import 'fingering.dart';

class FingeringFeedback {
  final int beatIndex;
  final Fingering answer;
  final List<int> wrongStringNumbers;

  FingeringFeedback({
    required this.beatIndex,
    required this.answer,
    required this.wrongStringNumbers,
  });

  String get feedbackMessage =>
      "${answer.chord.fullNameWithoutOctave}를 연주할 때 ${_listToString(wrongStringNumbers)}번 줄을 잘못 잡았어요. 😢";

  String _listToString(List<int> numbers) {
    final buffer = StringBuffer();

    for (int i = 0; i < numbers.length; ++i) {
      int number = numbers[i];
      buffer.write(number);

      if (i != numbers.length - 1) {
        buffer.write(", ");
      }
    }

    return buffer.toString();
  }
}
