import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_de_residuos/JsonModels/note_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();

  final title = TextEditingController();
  final content = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    notes = handler.getNotes();

    handler.initDB().whenComplete(() {
      notes = getAllNotes();
    });
    super.initState();
  }

  Future<List<NoteModel>> getAllNotes() {
    return handler.getNotes();
  }

  //Search method here
  //First we have to create a method in Database helper class
  Future<List<NoteModel>> searchNote() {
    return handler.searchNotes(keyword.text);
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      notes = getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(36, 56, 57, 1),
                  Color.fromRGBO(60, 104, 105, 1),
                  Color.fromRGBO(127, 106, 89, 1),
                ],
              )
          ),
          child: Column(
            children: [
              //Search Field here
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: keyword,
                  onChanged: (value) {
                    //When we type something in textfield
                    if (value.isNotEmpty) {
                      setState(() {
                        notes = searchNote();
                      });
                    } else {
                      setState(() {
                        notes = getAllNotes();
                      });
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      hintText: "Search"),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<NoteModel>>(
                  future: notes,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NoteModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text("No data"));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      final items = snapshot.data ?? <NoteModel>[];
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              subtitle: Text(DateFormat("yMd").format(
                                  DateTime.parse(items[index].createdAt))),
                              title: Text(items[index].noteTitle),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  //We call the delete method in database helper
                                  db
                                      .deleteNote(items[index].noteId!)
                                      .whenComplete(() {
                                    //After success delete , refresh notes
                                    //Done, next step is update notes
                                    _refresh();
                                  });
                                },
                              ),
                              onTap: () {
                                //When we click on note
                                setState(() {
                                  title.text = items[index].noteTitle;
                                  content.text = items[index].noteContent;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  //Now update method
                                                  db
                                                      .updateNote(
                                                      title.text,
                                                      content.text,
                                                      items[index].noteId)
                                                      .whenComplete(() {
                                                    //After update, note will refresh
                                                    _refresh();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Update"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                            ],
                                          ),
                                        ],
                                        title: const Text("Update note"),
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              //We need two textfield
                                              TextFormField(
                                                controller: title,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Title is required";
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                  label: Text("Title"),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: content,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Content is required";
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                  label: Text("Content"),
                                                ),
                                              ),
                                            ]),
                                      );
                                    });
                              },
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
