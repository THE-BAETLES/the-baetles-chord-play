// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/providers/home_screen.dart';
import 'package:the_baetles_chord_play/screens/sign_in_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("start");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => SignInPage(),
        '/home-screen' : (context) => HomeScreen()
      },
    );
  }
}