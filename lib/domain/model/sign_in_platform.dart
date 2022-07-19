enum SignInPlatform {
  GOOGLE("go");

  const SignInPlatform(this.name);

  final String name;

  @override
  String toString() {
    return name;
  }
}