import 'package:flutter/material.dart';

import '../models/note_model.dart';
class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.home_notes});
 final List<Note> home_notes;
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  List<Note> notes = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notes= List.from(widget.home_notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            //TextFormField for title input from user
            TextFormField(
              style: TextStyle(fontSize: 25),
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey,fontSize: 25),
              ),
            ),

            const SizedBox(height: 10,),

            //TextFormField for body input from user
            TextFormField(
              style: TextStyle(fontSize: 20),
              controller: bodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note",
                hintStyle: TextStyle(color: Colors.grey,fontSize: 25),
              ),
            ),
          ],
        ),
      ),

      //Button to save new or created note
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(titleController.text.isEmpty){
              return;
            }
            if(bodyController.text.isEmpty){
              return;
            }
            // In the FloatingActionButton's onPressed:
            final note = Note(
              id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate unique ID
              title: titleController.text,
              body: bodyController.text,
            );

            //calling onNewNoteCreated which is on HomeScreen to save note
            // widget.onNewNoteCreated(note);
            onNewNoteCreated(note);
            Navigator.of(context).pop(notes);
          },
          child: Icon(Icons.save),
      ),
    );
  }

  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});

  }
}
