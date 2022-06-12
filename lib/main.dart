// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widgets/atoms/VideoThumbnail.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chord Play"),
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
        ),
        body: Center(
          child: VideoThumbnail()
        ),
      ),
    );
  }
}