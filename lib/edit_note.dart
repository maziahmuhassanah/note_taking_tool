import 'package:flutter/material.dart';

class EditNotePage extends StatelessWidget {
  final String initialDetails;
  final TextEditingController detailsController = TextEditingController();

  EditNotePage({required this.initialDetails});

  @override
  Widget build(BuildContext context) {
    detailsController.text = initialDetails;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: detailsController,
              maxLines: null, // Allow multiple lines
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated details and navigate back to the previous screen
                Navigator.pop(context, detailsController.text);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}