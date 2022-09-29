class FeedbackState {
  late final Set<int> _correctIndexes;
  late final Set<int> _wrongIndexes;

  FeedbackState({
    Set<int>? correctIndexes,
    Set<int>? wrongIndexes,
  }) {
    _correctIndexes = correctIndexes ?? {};
    _wrongIndexes = wrongIndexes?? {};
  }

  Set<int> get correctIndexes => Set.of(_correctIndexes);
  Set<int> get wrongIndexes => Set.of(_wrongIndexes);

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
