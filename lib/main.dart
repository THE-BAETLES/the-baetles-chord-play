// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:the_baetles_chord_play/widgets/atoms/VideoThumbnail.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chord Play"),
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
        ),
        body: Column(
          children: [
            VideoThumbnail(),
            ChordDetectionTest(),
          ]
        ),
      ),
    );
  }
}

class ChordDetectionTest extends StatefulWidget {
  const ChordDetectionTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChordDetectionTestState();
}

class _ChordDetectionTestState extends State<ChordDetectionTest> {
  static const platform = MethodChannel('com.example.baetles/chord-detection');

  String _lastPlayedChord = "Unknown chord.";

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [ElevatedButton(
            onPressed: _startDetectingChord,
            child: Text("음 판별 시작")
        ),
        Text(_lastPlayedChord),
      ]
    );
  }

  Future<void> _startDetectingChord() async {
    String chord;

    try {
      final int result = await platform.invokeMethod('startDetectingChord');
      chord = 'Played chord is $result';
    } on PlatformException catch (e) {
      chord = "Failed to get played chord: '${e.message}'.";
    }

    setState(() {
      // 결과 저장
      _lastPlayedChord = chord;
    });
  }
}