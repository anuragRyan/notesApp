import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {

    title = TextEditingController(text: widget.docToEdit.data()['title']);
    content = TextEditingController(text: widget.docToEdit.data()['content']);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          TextButton(
              onPressed: () {
                widget.docToEdit.reference.update({
                  'title' : title.text,
                  'content' : content.text
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 23),)
          ),
          TextButton(
              onPressed: () {
                widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
              },
              child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 23),)
          )
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
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
}
