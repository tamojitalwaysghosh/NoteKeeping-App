import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:noter/db/notes_database.dart';
import 'package:noter/model/note.dart';
import 'package:noter/navbar/bottom_nav.dart';
import 'package:noter/page/edit_note_page.dart';
import 'package:noter/page/note_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noter/screens/login_page.dart';
import 'package:noter/screens/notifications.dart';
import 'package:noter/screens/profile_screen.dart';
import 'package:noter/widget/note_card_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'KeepANote',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quicksand',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : notes.isEmpty
                  ? Text(
                      'Looking so empty \nadd some notes!',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 24),
                    )
                  : StaggeredGridView.countBuilder(
                      padding: EdgeInsets.all(8),
                      itemCount: notes.length,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        final note = notes[index];

                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailPage(noteId: note.id!),
                            ));

                            refreshNotes();
                          },
                          child: NoteCardWidget(note: note, index: index),
                        );
                      },
                    ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 50),
          //color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                // onTap: () => Navigator.push(context,
                //MaterialPageRoute(builder: (_) => NewTaskScreen())),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEditNotePage()),
                  );

                  refreshNotes();
                },
                child: Container(
                  padding: EdgeInsets.all(12.4),
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.amber,
                        size: 27,
                      ),
                      Text(
                        'Add new note',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    //boxShadow: [
                    //BoxShadow(
                    //  blurRadius: 0.3,
                    //  offset: Offset(0, 0),
                    //),
                    // BoxShadow(blurRadius: 2, offset: Offset(2, 2))
                    //],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
