enum LoginPlatform {
  google("go"),
  apple("ap"),
  facebook("fa");

  const LoginPlatform(this.platformCode);
  final String platformCode;
}