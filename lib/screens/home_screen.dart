import 'package:flutter/material.dart';
import 'package:sql_app/data/local/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

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
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
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
            /// static notes being added
            // bool check = await dbRef!.addNote(
            //     note_title: "First Note",
            //     note_desc: "This is the firsst note description");
            // if (check) {
            //   getNotes();
            // }
            //user input notes
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          'Add Note',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              label: Text('Note Title'),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          maxLines: 6,
                          controller: descController,
                          decoration: InputDecoration(
                              label: Text('Note Description'),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              var note_title = titleController.text;
                              var note_desc = descController.text;
                              if (note_title.isNotEmpty && )
                            },
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                                foregroundColor: Colors.white))
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.add)),
    );
  }
}
