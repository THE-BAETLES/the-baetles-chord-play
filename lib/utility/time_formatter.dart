class TimeFormatter {
  static const none = 0;

  static String formatDurationToHms(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    String text;

    if (hours == none) {
      text = "${minutes}:${seconds.toString().padLeft(2, '0')}";
    } else {
      text = "${hours}:${minutes}:${seconds.toString().padLeft(2, '0')}";
    }

    return text;
  }
}