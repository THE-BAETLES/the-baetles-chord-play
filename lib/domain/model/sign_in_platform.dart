enum SignInPlatform {
  GOOGLE("go"),
  APPLE("ap");

  const SignInPlatform(this.name);

  final String name;

  @override
  String toString() {
    return name;
  }
}