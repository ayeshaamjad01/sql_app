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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES '),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      //all nites visible
      body: ListView.builder(itemBuilder: (_, index) {}),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ///note to be added from
          },
          child: Icon(Icons.add)),
    );
  }
}
