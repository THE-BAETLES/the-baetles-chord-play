enum TriadType {
  major('maj'),
  minor('min'),
  augmented('aug'),
  diminished('dim');

  const TriadType(this.notation);
  final String notation;
}