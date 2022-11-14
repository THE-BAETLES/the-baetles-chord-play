import '../../../domain/model/fingering_feedback.dart';

class FeedbackState {
  late final Set<int> _correctIndexes;
  late final Set<int> _wrongIndexes;
  late final List<FingeringFeedback> _feedbacks;

  FeedbackState({
    Set<int>? correctIndexes,
    Set<int>? wrongIndexes,
    List<FingeringFeedback>? feedbacks,
  }) {
    _correctIndexes = correctIndexes ?? {};
    _wrongIndexes = wrongIndexes ?? {};
    _feedbacks = feedbacks ?? [];
  }

  Set<int> get correctIndexes => Set.of(_correctIndexes);
  Set<int> get wrongIndexes => Set.of(_wrongIndexes);
  List<FingeringFeedback> get feedbacks => List.of(_feedbacks);

  bool isCorrect(int index) {
    return _correctIndexes.contains(index);
  }

  bool isWrong(int index) {
    return _wrongIndexes.contains(index);
  }

  bool isNotMarked(int index) {
    return !(isCorrect(index) || isWrong(index));
  }

  bool addMarkedIndex(int index, bool isCorrect) {
    if (isCorrect) {
      _wrongIndexes.remove(index);
      return _correctIndexes.add(index);
    } else {
      _correctIndexes.remove(index);
      return _wrongIndexes.add(index);
    }
  }

  void addFeedback(FingeringFeedback feedback) {
    this._feedbacks.add(feedback);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackState &&
          runtimeType == other.runtimeType &&
          _correctIndexes == other._correctIndexes &&
          _wrongIndexes == other._wrongIndexes;

  @override
  int get hashCode => _correctIndexes.hashCode ^ _wrongIndexes.hashCode;
}
