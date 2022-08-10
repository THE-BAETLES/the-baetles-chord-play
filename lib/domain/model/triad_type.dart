enum TriadType {
  major('maj', 'M'),
  minor('min', 'm'),
  augmented('aug', 'a'),
  diminished('dim', 'd');

  const TriadType(this.notation, this.shortNotation);
  final String notation;
  final String shortNotation;
}