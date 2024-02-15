import 'package:flutter/material.dart';
import 'edit_note.dart';
import './models/Note.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Note note;

  NoteDetailsScreen({required this.note});

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}
class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController detailsController;

  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController(text: widget.note.details);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.subject),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Navigate to the EditNotePage when the edit icon is pressed
              String? updatedDetails = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNotePage(initialDetails: widget.note.details),
                ),
              );

              if (updatedDetails != null) {
                // If details are updated, update the UI and note
                setState(() {
                  widget.note.details = updatedDetails;
                  widget.note.date = DateTime.now(); // Update the date
                  detailsController.text = updatedDetails;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.note.details),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
