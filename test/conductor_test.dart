import 'package:flutter_test/flutter_test.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_service.dart';

void main() {
  group('Conductor service test', () {
    test('count up timer', () async {
      final stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countUp,
        presetMillisecond: 0,
      );

      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      await Future.delayed(Duration(milliseconds: 235));

      print('start');

      while (true) {
        print('${stopWatchTimer.isRunning}');
        // await stopWatchTimer.rawTime.listen((value) => print('omg $value'));
        int rawTime = stopWatchTimer.rawTime.value;
        await Future.delayed(Duration(milliseconds: 100));
        int secondTime = stopWatchTimer.secondTime.value;
        print('${rawTime} ms | $secondTime sec');
      }
    });
  });
}