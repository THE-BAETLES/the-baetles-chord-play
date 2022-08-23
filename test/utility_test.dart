import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/utility/time_formatter.dart';

void main() {
  group('TimeFormatter test', ()
  {
    test('format hms', () {
      Duration duration1 = Duration(milliseconds: 36000);
      expect(TimeFormatter.formatDurationToHms(duration1), "0:36");

      Duration duration2 = Duration(milliseconds: 162452);
      expect(TimeFormatter.formatDurationToHms(duration2), "2:42");

      Duration duration3 = Duration(milliseconds: 825613);
      expect(TimeFormatter.formatDurationToHms(duration3), "13:45");

      Duration duration4 = Duration(milliseconds: 34428426);
      expect(TimeFormatter.formatDurationToHms(duration4), "9:33:48");

      Duration duration6 = Duration(milliseconds: 114563526);
      expect(TimeFormatter.formatDurationToHms(duration6), "31:49:23");
    });
  });
}