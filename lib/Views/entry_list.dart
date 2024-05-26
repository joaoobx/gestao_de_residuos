import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gerenciamento_de_residuos/JsonModels/note_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';
import 'package:gerenciamento_de_residuos/Views/create_entry.dart';
import 'package:gerenciamento_de_residuos/Views/edit_entry.dart';
import 'package:intl/intl.dart';

class EntryList extends StatefulWidget {
  const EntryList({super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();

  final title = TextEditingController();
  final content = TextEditingController();
  final createdAt = TextEditingController();
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
            children: [
              Padding(padding: EdgeInsets.all(54.0)),
              Image(
                image: AssetImage('lib/assets/leaves.png'),
                width: 33,
              )
            ],
          ),
        ),
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
            )),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(40.0)),
                //Search Field here
                const Text("Entrada de Resíduos",
                    style: TextStyle(fontSize: 24)),
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
                                leading: SizedBox(
                                  height: 42,
                                  width: 164,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 3, 5, 0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        backgroundColor: const Color.fromRGBO(
                                            69, 161, 134, 1)),
                                    onPressed: () => {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              items[index].type,
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1)),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${items[index].weight} Kg",
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat("yMd").format(
                                                  DateTime.parse(
                                                      items[index].createdAt)),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.6),
                                                  fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              items[index].location,
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.6),
                                                  fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 164,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 42,
                                        width: 82,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      194, 196, 108, 1),
                                              padding:
                                                  const EdgeInsets.all(0.0)),
                                          onPressed: () {
                                            //We need call refresh method after a new note is created
                                            //Now it works properly
                                            //We will do delete now
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const EditEntry()))
                                                .then((value) {
                                              if (value) {
                                                //This will be called
                                                _refresh();
                                              }
                                            });
                                          },
                                          child: const Text(
                                            "Editar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(1.0)),
                                      SizedBox(
                                        height: 42,
                                        width: 80,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      196, 108, 108, 1),
                                              padding:
                                                  const EdgeInsets.all(0.0)),
                                          onPressed: () {
                                            //We call the delete method in database helper
                                            db
                                                .deleteNote(
                                                    items[index].noteId!)
                                                .whenComplete(() {
                                              //After success delete , refresh notes
                                              //Done, next step is update notes
                                              _refresh();
                                            });
                                          },
                                          child: const Text(
                                            "Excluir",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 41,
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90)),
                        backgroundColor: const Color.fromRGBO(69, 161, 134, 1),
                        padding: const EdgeInsets.all(0.0)),
                    onPressed: () {
                      //We need call refresh method after a new note is created
                      //Now it works properly
                      //We will do delete now
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateEntry()))
                          .then((value) {
                        if (value) {
                          //This will be called
                          _refresh();
                        }
                      });
                    },
                    child: const Text(
                      "Cadastrar entrada",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20.0))
              ],
            )));
  }
}
