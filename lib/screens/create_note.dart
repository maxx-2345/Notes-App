import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              //TextFormField for title input from user
              TextFormField(
                maxLength: 15,
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
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
      ),

      //Button to save new or created note
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            _formattedMyDate(DateTime.now());
            print("datetime: ${ DateTime.now()}");
            // dd-mm-yyy
            // dd-mm-yy
            //
            if(titleController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter title")));
              return ;
            }
            if(bodyController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your thoughts")));
              return;
            }
            String formatted = DateFormat('dd/MM/yyyy hh:mm aaa').format(DateTime.now());
            // In the FloatingActionButton's onPressed:
            final note = Note(
              createdDate: formatted,
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

  String _formattedMyDate(DateTime date){
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm aaa').format(currentDate);
    print("formattedDate:: $formattedDate");
    return formattedDate;
  }
  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});

  }
}
