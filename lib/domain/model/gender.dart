enum Gender {
  male("male"),
  female("female"),
  none("none");

  const Gender (this.name);

  final String name;

  @override
  String toString() {
    return name;
  }
}