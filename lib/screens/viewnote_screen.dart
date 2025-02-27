
import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'package:share_plus/share_plus.dart';

class ViewNoteScreen extends StatelessWidget {
  final Note note;

  const ViewNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareNote(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.body,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareNote(BuildContext context) {
    Share.share(
      '${note.title}\n\n${note.body}',
      subject: 'Note from My Notes App',
    );
  }
}