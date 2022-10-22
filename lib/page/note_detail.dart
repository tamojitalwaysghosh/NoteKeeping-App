import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noter/db/notes_database.dart';
import 'package:noter/model/note.dart';
import 'package:noter/page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        color: Color.fromARGB(255, 22, 20, 20),
                        fontSize: 22,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      thickness: 0.67,
                    ),
                    Row(
                      children: [
                        Text(
                          'Added on:',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(note.createdTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(
                      thickness: 0.67,
                    ),
                    Text(
                      note.description,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                      ),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: Colors.grey,
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.grey,
        ),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
