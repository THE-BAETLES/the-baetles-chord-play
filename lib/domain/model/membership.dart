enum Membership {
  basic("basic"),
  premium("premium");

  const Membership(this.name);

  final String name;

  @override
  String toString() {
    return name;
  }
}