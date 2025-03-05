import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'package:share_plus/share_plus.dart';

class ViewNoteScreen extends StatefulWidget {
  final Note note;
  final Function(Note) onUpdate;

  const ViewNoteScreen({super.key, required this.note, required this.onUpdate});

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  bool isEditing = false; // Track edit mode

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Note'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit), // Edit or Save icon
            onPressed: _toggleEdit,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareNote(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              enabled: isEditing, // Enable only in edit mode
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: bodyController,
                style: const TextStyle(fontSize: 18),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                enabled: isEditing, // Enable only in edit mode
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEdit() {
    if (isEditing) {
      // Save the updated note and pass it back
      widget.onUpdate(Note(
        id: widget.note.id,
        title: titleController.text,
        body: bodyController.text,
      ));
    }
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _shareNote() {
    Share.share(
      '${titleController.text}\n\n${bodyController.text}',
      subject: 'Note from My Notes App',
    );
  }
}



