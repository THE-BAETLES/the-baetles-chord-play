class SheetElementSize {
  late final double sheetHeight;
  late final double sheetWidth;

  late final int measureCount;

  late final double tileWidth;
  late final double tileHeight;
  late final double spaceWidth;
  late final double spaceHeight;
  late final double barWidth;
  late final double barHeight;
  late final double chordRootTextSize;
  late final double chordPostfixTextSize;

  SheetElementSize({
    required this.sheetHeight,
    required this.sheetWidth,
    required this.measureCount,
    required this.tileWidth,
    required this.tileHeight,
    required this.spaceWidth,
    required this.spaceHeight,
    required this.barWidth,
    required this.barHeight,
    required this.chordRootTextSize,
    required this.chordPostfixTextSize,
  });

  SheetElementSize.resize({
    required this.sheetHeight,
    required this.sheetWidth,
    required this.measureCount,
    required this.spaceWidth,
    double? spaceHeight,
    required this.barWidth,
    double? barHeight,
  }) {
    tileWidth = (sheetWidth - (5 * measureCount + 1) * spaceWidth - measureCount * barWidth) / (4 * measureCount);
    tileHeight = tileWidth;

    this.spaceHeight = spaceHeight ?? tileHeight;
    this.barHeight = barHeight ?? tileHeight;

    this.chordRootTextSize = tileHeight / 2.5;
    this.chordPostfixTextSize = tileHeight / 3.5;
  }
}
