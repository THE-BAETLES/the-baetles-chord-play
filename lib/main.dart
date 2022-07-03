// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widgets/atoms/VideoThumbnail.dart';

import 'models/note.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 88; i++) {
      Note chord1 = Note(i);
      print("$i  ${chord1.noteNumber}  ${chord1.keyNumber}  ${chord1.toString()}");
      Note chord2 = Note.fromNoteName(chord1.toString());
      print("$i  ${chord2.noteNumber}  ${chord2.keyNumber}  ${chord2.toString()}");
    }

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