import 'package:flutter_test/flutter_test.dart';
import 'package:the_baetles_chord_play/domain/model/loop.dart';
import 'package:tuple/tuple.dart';

void main() {
  group("loop constructor test", () {
    test("givenValidParameter_whenConstructLoop_thenConstructProperly", () {
      List<Tuple2<int, int>> testCases = [
        const Tuple2(0, 30),
        const Tuple2(0, 0),
        const Tuple2(0, 100000),
        const Tuple2(0, -0),
        const Tuple2(2100000000, 2100000000),
        const Tuple2(-21000, 2262345),
        const Tuple2(152345, 135425737),
      ];

      for (Tuple2<int, int> testCase in testCases) {
        int start = testCase.item1;
        int length = testCase.item2;

        Loop loop = Loop(start, length);
        expect(loop.start, start);
        expect(loop.length, length);
      }
    });

    test("givenInvalidParameter_whenConstructLoop_thenThrowException", () {
      List<Tuple2<int, int>> testCases = [
        const Tuple2(0, -30),
        const Tuple2(0, -26634),
        const Tuple2(0, -100000),
        const Tuple2(-2100000000, -2100000000),
        const Tuple2(-21000, -2262345),
        const Tuple2(152345, -135425737),
      ];

      for (Tuple2<int, int> testCase in testCases) {
        int start = testCase.item1;
        int length = testCase.item2;

        expect(() => Loop(start, length), throwsException);
      }
    });
  });
}
