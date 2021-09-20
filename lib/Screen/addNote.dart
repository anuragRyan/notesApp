import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/main.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          TextButton(
            onPressed: () {
              add();
            },
            child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 23),))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[700]
            ),
            child: TextField(
              controller: title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white70),
              decoration: InputDecoration(
                hintText: 'TITLE', hintStyle: TextStyle(fontSize: 20, color: Colors.white70)
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[700]
              ),
              child: TextField(
                controller: content,
                maxLines: null,
                expands: true,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white70),
                decoration: InputDecoration(
                    hintText: 'Content', hintStyle: TextStyle(color: Colors.white70, fontSize: 20)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void add() async {

    CollectionReference ref = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid).collection('notes');

    var data = {
      'title' : title.text,
      'content' : content.text,
      'time' : DateTime.now()
    };

    await ref.add(data);

    Navigator.pop(context);

  }
}
