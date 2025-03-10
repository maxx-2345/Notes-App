import 'package:flutter/material.dart';
import 'package:my_notes/screens/viewnote_screen.dart';
import 'package:my_notes/screens/widgets/note_card.dart';
import 'package:share_plus/share_plus.dart';
import '../models/note_model.dart';
import 'create_note.dart';
import 'package:intl/intl.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Note> notes = [];
 String searchQuery = "";

TextEditingController searchController = TextEditingController();

List<Note> get filteredNotes {
  if(searchQuery.isEmpty){
    return notes;
  }

  return notes.where((note) =>
      note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
      note.body.toLowerCase().contains(searchQuery.toLowerCase())
  ).toList();


}
@override
  void dispose() {
    // TODO: implement dispose
  searchController.dispose();
    super.dispose();

  }
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
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search notes",
                hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                border: OutlineInputBorder(),
                suffixIcon: searchQuery.isNotEmpty ?
                IconButton(
              icon: Icon(Icons.clear),
              onPressed: (){
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
              ) : null
              ),
             onChanged: (value) {
               searchQuery=  value;
             },
            ),
          ),

          if(searchQuery.isNotEmpty && filteredNotes.isEmpty)
            Padding(
                padding: EdgeInsets.all(8),
                    child: Text("No notes found \"$searchQuery\"",style: TextStyle(fontSize: 16,color: Colors.grey),),
            ),



          Expanded(
            child: ListView.builder(
              itemCount: filteredNotes.length,
                itemBuilder: (context,index){
                return NoteCard(
                    note: filteredNotes[index],
                    onDelete: () => onNoteDeleted(filteredNotes[index]),
                    onShare: () => shareContent(filteredNotes[index]),
                    onView: (note) => viewNote(filteredNotes[index]),
                );
                }
            ),
          ),
        ],
      ),

      //Button to create note
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            _navigateCreatenote();
          },
         child: Icon(Icons.add),
      ),
    );
  }

  //Function to create a note rest of the logic is on create_note
  // void onNewNoteCreated(Note note){
  //   notes.add(note);
  //   setState(() {});
  // }

  void _navigateCreatenote() async{
    final updateNotes = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateNote(home_notes:notes)));

      setState(() {
        notes = updateNotes;
      });

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
  void viewNote(Note note) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewNoteScreen(
          note: note,
          onUpdate: (updatedNote) {
            setState(() {
              int index = notes.indexWhere((n) => n.id == updatedNote.id);
              if (index != -1) {
                notes[index] = updatedNote; // Update the note
              }
            });
          },
        ),
      ),
    );
  }

}
