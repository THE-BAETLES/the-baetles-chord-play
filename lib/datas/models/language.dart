enum Language {
  korean("kor", "한국어"),
  english("eng", "english");

  const Language(this.languageCode, this.nameInLocal);

  final String languageCode;
  final String nameInLocal;

  @override
  String toString() {
    return languageCode;
  }
}