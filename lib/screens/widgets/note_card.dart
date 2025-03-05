import 'package:flutter/material.dart';

import '../../models/note_model.dart';



class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onShare,
    required this.onView,
  });

  final Note note;
  final VoidCallback onDelete;
  final Function onShare;
  final Function(Note) onView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onView(note),  // it sends to viewnote_screen
      onLongPress: () => _showDeleteDialog(context), //Shows a AlertDialog with with share and delete option
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              Text(note.body, maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,),
              )],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),

          //Share Button on AlertDialog
          TextButton(
              onPressed: (){
            onShare();
          }, child: Text("Share",style: TextStyle(color: Colors.green),)),

          //Delete Button on AlertDialog
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete(); // Trigger deletion
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
