// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';
import 'new_file.dart'; // Importing necessary files
import 'note_details.dart';
import './models/Note.dart';
import 'note_search.dart';

void main() {
  runApp(
    // ThemeProvider(
    //   saveThemesOnChange: true,
    //   loadThemeOnInit: true,
    //   themes: [
    //     AppTheme.dark(),
    //     AppTheme.light(),
      // child: 
      MyApp(),
    //),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Note Taking App',
          debugShowCheckedModeBanner: false,
          theme: ThemeProvider.themeOf(context).data,
          home: NoteListScreen(),
        ),
      ),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [
    // Sample notes for demonstration
    Note(
      subject: 'Meeting 1',
      details: 'Discuss project milestones and upcoming deadlines.',
      date: DateTime(2023, 12, 15),
    ),
    Note(
      subject: 'Meeting 2',
      details: 'Checking on progress.',
      date: DateTime(2023, 12, 25),
    ),
  ];
  List<Note> filteredNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // Show the search dialog and wait for the result
              String? searchQuery = await showSearch<String>(
                context: context,
                delegate: NoteSearchDelegate(notes),
              );

              if (searchQuery != null) {
                setState(() {
                  // Update the list with the filtered notes
                  filteredNotes = notes
                      .where((note) =>
                          note.subject.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();
                });
              }
            },
          ),
          ThemeConsumer(
            child: Builder(
              builder: (themeContext) => IconButton(
                icon: Icon(
                  ThemeProvider.themeOf(themeContext).id == 'light'
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  ThemeProvider.controllerOf(context).nextTheme();
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Note Subjects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              accountEmail: null,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/note_pic.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            for (var note in notes)
              ListTile(
                title: Text(note.subject),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the details screen for the selected note
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailsScreen(note: note),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredNotes.isNotEmpty ? filteredNotes.length : notes.length,
        itemBuilder: (context, index) {
          Note currentNote = filteredNotes.isNotEmpty ? filteredNotes[index] : notes[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentNote.subject),
                Text(
                  'Date: ${DateFormat.yMMMMd().format(currentNote.date)}', // Format the date
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteDetailsScreen(note: currentNote),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  notes.remove(currentNote);
                  filteredNotes.remove(currentNote);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Note? newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );

          if (newNote != null) {
            newNote.date = DateTime.now(); // Set the current date
            setState(() {
              notes.add(newNote);
              filteredNotes.add(newNote);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
//  class AppTheme {
//   static light()  {
//     return ThemeData.light().copyWith(
//       primaryColor: Colors.yellow,
    //   );
    // }
    
    // static dark() {
    //   return ThemeData.dark().copyWith(
    //     primaryColor: Colors.lightBlue,
    //   );
    // }

    //  }
