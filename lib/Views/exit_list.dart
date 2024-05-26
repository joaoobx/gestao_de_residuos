import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/JsonModels/exit_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';
import 'package:gerenciamento_de_residuos/Views/create_entry.dart';
import 'package:gerenciamento_de_residuos/Views/create_exit.dart';
import 'package:gerenciamento_de_residuos/Views/edit_entry.dart';
import 'package:gerenciamento_de_residuos/Views/edit_exit.dart';
import 'package:intl/intl.dart';

class ExitList extends StatefulWidget {
  const ExitList({super.key});

  @override
  State<ExitList> createState() => _ExitListState();
}

class _ExitListState extends State<ExitList> {
  late DatabaseHelper handler;
  late Future<List<ExitModel>> exits;
  final db = DatabaseHelper();

  final title = TextEditingController();
  final content = TextEditingController();
  final createdAt = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    exits = handler.getExits();

    handler.initDB().whenComplete(() {
      exits = getAllExits();
    });
    super.initState();
  }

  Future<List<ExitModel>> getAllExits() {
    return handler.getExits();
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      exits = getAllExits();
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
                const Text("Saida de Resíduos", style: TextStyle(fontSize: 24)),
                Expanded(
                  child: FutureBuilder<List<ExitModel>>(
                    future: exits,
                    builder: (BuildContext context, AsyncSnapshot<List<ExitModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(child: Text("No data"));
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        final items = snapshot.data ?? <ExitModel>[];
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 53,
                                  width: 213,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.fromLTRB(5, 3, 5, 3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: const Color.fromRGBO(69, 161, 134, 1)),
                                    onPressed: () => {},
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              items[index].type,
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              items[index].supplier,
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${items[index].weight} Kg",
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat("yMd").format(DateTime.parse(items[index].createdAt)),
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "R\$ ${items[index].revenue}",
                                              style: const TextStyle(color: Color.fromRGBO(2, 27, 251, 1), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              items[index].location,
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              items[index].cdf,
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "R\$ ${items[index].cost}",
                                              style: const TextStyle(color: Color.fromRGBO(251, 2, 2, 1), fontSize: 10),
                                            ),
                                            const Spacer(),
                                            Text(
                                              items[index].mtr,
                                              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 10),
                                            ),
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
                                      const Padding(padding: EdgeInsets.all(20.0)),
                                      SizedBox(
                                        height: 41,
                                        width: 60,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(side: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.6)), borderRadius: BorderRadius.circular(5)), backgroundColor: const Color.fromRGBO(194, 196, 108, 1), padding: const EdgeInsets.all(0.0)),
                                          onPressed: () {
                                            //We need call refresh method after a new note is created
                                            //Now it works properly
                                            //We will do delete now
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditExit(
                                                          editExitId: items[index].exitId,
                                                          editLocation: items[index].location,
                                                          editType: items[index].type,
                                                          editWeight: items[index].weight,
                                                          editCdf: items[index].cdf,
                                                          editCost: items[index].cost,
                                                          editMtr: items[index].mtr,
                                                          editRevenue: items[index].revenue,
                                                          editSupplier: items[index].supplier,
                                                        ))).then((value) {
                                              if (value) {
                                                //This will be called
                                                _refresh();
                                              }
                                            });
                                          },
                                          child: const Text(
                                            "Editar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.all(1.0)),
                                      SizedBox(
                                        height: 41,
                                        width: 60,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.6)),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              backgroundColor: const Color.fromRGBO(196, 108, 108, 1),
                                              padding: const EdgeInsets.all(0.0)),
                                          onPressed: () {
                                            //We call the delete method in database helper
                                            db.deleteExit(items[index].exitId!).whenComplete(() {
                                              //After success delete , refresh notes
                                              //Done, next step is update notes
                                              _refresh();
                                            });
                                          },
                                          child: const Text(
                                            "Excluir",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
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
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)), backgroundColor: const Color.fromRGBO(69, 161, 134, 1), padding: const EdgeInsets.all(0.0)),
                    onPressed: () {
                      //We need call refresh method after a new note is created
                      //Now it works properly
                      //We will do delete now
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateExit())).then((value) {
                        if (value) {
                          //This will be called
                          _refresh();
                        }
                      });
                    },
                    child: const Text(
                      "Cadastrar saida",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 12),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20.0))
              ],
            )));
  }
}
