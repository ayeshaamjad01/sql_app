import 'package:flutter/material.dart';
import 'package:sql_app/data/local/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = DBHelper.getInstance();
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES '),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      //all nites visible
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text('${allNotes[index][DBHelper.COLUMN_NOTE_SNO]}'),
                  title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                  subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                );
              },
            )
          : Center(child: Text('No Notes yet')),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ///note to be added from
            bool check = await dbRef!.addNote(
                note_title: "First Note",
                note_desc: "This is the firsst note description");
            if (check) {
              getNotes();
            }
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.add)),
    );
  }
}
