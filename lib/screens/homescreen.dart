import 'package:flutter/material.dart';
import 'package:my_notes/screens/viewnote_screen.dart';
import 'package:my_notes/screens/widgets/note_card.dart';
import 'package:share_plus/share_plus.dart';
import '../models/note_model.dart';
import 'create_note.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value){
              if(value == 'Share'){
                print(value);
              } else if(value == 'Delete'){
                print(value);
              } else if(value == 'Archive'){
                print(value);
              }
            },
              itemBuilder: (context) => [
                 PopupMenuItem(
                  value: 'Share',
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 2,),
                        Text("Share")
                      ],
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Archive',
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(Icons.archive),
                        SizedBox(width: 2,),
                        Text("Archive")
                      ],
                    ),
                  ),
                ),
              ]
          ),
        ],
      ),
      body:ListView.builder(
        itemCount: notes.length,
          itemBuilder: (context,index){
          return NoteCard(
              note: notes[index],
              onDelete: () => onNoteDeleted(notes[index]),
              onShare: () => shareContent(notes[index]),
              onView: (note) => viewNote(notes[index]),
          );
          }
      ),

      //Button to create note
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateNote(onNewNoteCreated: onNewNoteCreated,),
            ));
          },
         child: Icon(Icons.add),
      ),
    );
  }

  //Function to create a note rest of the logic is on create_note
  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});
  }


  // Function to delete a note rest of the logic is on note_card
  void onNoteDeleted(Note note){
    notes.remove(note);
    setState(() {});
  }


  // Function to share content rest of the logic is on note_card
Future<void> shareContent(Note note) async{
    try{
      await Share.share(
        'Check out this note: \nTitle: ${note.title}\nBody:${note.body}',
        subject: 'Shared Note',
      );
    }catch(e){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occurred $e")));
    }
}


//Function to view note on a separate screen => viewnote_screen
  void viewNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewNoteScreen(note: note),
      ),
    );
  }

}
