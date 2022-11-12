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
}
