import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addNote.dart';
import 'editNote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CollectionReference ref = FirebaseFirestore.instance.collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid).collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('My Notes', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote()));
        },
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.add, color: Colors.grey[800], size: 35,),
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(docToEdit: snapshot.data.docs[index],)));
                    },
                    child: Container(
                      height: 150,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey[700],
                      ),
                      child: Column(
                        children: [
                          Text(snapshot.data.docs[index].data()['title'], style: TextStyle(color: Colors.white, fontSize: 18),),
                          SizedBox(height: 5),
                          Text(snapshot.data.docs[index].data()['content'],style: TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ),
                  );
                });
          }
      ),
    );
  }
}
