import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/Screen/addNote.dart';
import 'package:notesapp/Screen/editNote.dart';
import 'package:notesapp/Screen/homeScreen.dart';
import 'package:notesapp/Screen/loginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
