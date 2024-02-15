import 'package:flutter/material.dart';
import './models/Note.dart';

class AddNotePage extends StatelessWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: detailsController,
              maxLines: null, // Allow multiple lines
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Add the new note and navigate back to the NoteListScreen
                Navigator.pop(
                  context,
                  Note(
                    subject: subjectController.text,
                    details: detailsController.text, 
                    date: DateTime.now(),
                  ),
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}