class Loop {
  final int start;
  final int length;

  int get end => start + length;

  Loop(this.start, this.length) {
    if (length < 0) {
      throw Exception("length of Loop should be positive");
    }
  }

  Loop.infinite() : start = 0, length = -1;

  bool isInLoop(int value) {
    return start <= value && value <= start + length;
  }

  bool isInfinite() {
    return start == 0 && length == -1;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Loop &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          length == other.length;

  @override
  int get hashCode => start.hashCode ^ length.hashCode;

  @override
  String toString() {
    if (this.isInfinite()) {
      return "${super.toString()} : inf";
    } else {
      return "${super.toString()} : start=${start}, end=${end}";
    }
  }
}
