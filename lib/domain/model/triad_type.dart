enum TriadType {
  major('maj', 'M'),
  majorSeven('maj7', 'M7'),
  minor('min', 'm'),
  minorSeven('min7', 'm7'),
  seven('7', '7'),
  six('6', '6'),
  addNine('add9', 'add9'),
  majorSevenNine('maj7(9)', 'M7(9)'),
  sixNine('6(9)', '6(9)'),
  majorSevenSharpEleven('maj7(♯11)', 'M7(♯11)'),
  augmented('aug', 'aug'),
  majorSevenAugmented('maj7aug', 'M7aug'),
  minorSix('min6', 'm6'),
  minorSevenFlatFive('min7(♭5)', 'm7(♭5)'),
  minorMajorSeven('minMaj7', 'mM7'),
  minorAddNine('minAdd9', 'madd9'),
  minorSevenNine('min7(9)', 'm7(9)'),
  minorMajorSevenNine('minMaj7(9)', 'mM7(9)'),
  minorSevenEleven('min7(11)', 'm7(11)'),
  sevenFlatFive('7(♭5)', '7(♭5)'),
  sevenNine('7(9)', '7(9)'),
  sevenFlatNine('7(♭9)', '7(♭9)'),
  sevenSharpNine('7(♯9)', '7(♯9)'),
  sevenSharpEleven('7(♯11)', '7(♯11)'),
  sevenThirteen('7(13)', '7(13)'),
  sevenFlatThirteen('7(♭13)', '7(♭13)'),
  sevenAugmented('7aug', '7aug'),
  suspendedFour('sus4', 'sus4'),
  sevenSuspendedFour('7sus4', '7sus4'),
  suspendedTwo('sus2', 'sus2'),

  diminished('dim', 'dim'),
  diminishedSeven('dim7', 'dim7'),

  none('', '');


  const TriadType(this.notation, this.shortNotation);
  final String notation;
  final String shortNotation;
}