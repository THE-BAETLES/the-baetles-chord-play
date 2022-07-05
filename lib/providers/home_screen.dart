import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          Text("hello"),
          Text(FirebaseAuth.instance.currentUser!.email!),
          Text(FirebaseAuth.instance.currentUser!.displayName!),
        ],
      ),
    );
  }
}