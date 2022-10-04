import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/utility/time_formatter.dart';

void main() {
  group('TimeFormatter test', ()
  {
    test('formatDurationToHms', () {
      Duration duration1 = Duration(milliseconds: 0);
      expect(TimeFormatter.formatDurationToHms(duration1), "0:00");

      Duration duration2 = Duration(milliseconds: 36000);
      expect(TimeFormatter.formatDurationToHms(duration2), "0:36");

      Duration duration3 = Duration(milliseconds: 162452);
      expect(TimeFormatter.formatDurationToHms(duration3), "2:42");

      Duration duration4 = Duration(milliseconds: 825613);
      expect(TimeFormatter.formatDurationToHms(duration4), "13:45");

      Duration duration5 = Duration(milliseconds: 34428426);
      expect(TimeFormatter.formatDurationToHms(duration5), "9:33:48");

      Duration duration6 = Duration(milliseconds: 114563526);
      expect(TimeFormatter.formatDurationToHms(duration6), "31:49:23");
    });

    log("TimeFormatter test complete");
  });
}