import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/JsonModels/exit_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';
import 'package:gerenciamento_de_residuos/Views/entry_list.dart';
import 'package:gerenciamento_de_residuos/Views/exit_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHelper handler;
  late Future<double> entrySum;
  late Future<double> exitSum;
  final db = DatabaseHelper();

  final title = TextEditingController();
  final content = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    entrySum = handler.getEntryWeightSum();
    exitSum = handler.getExitWeightSum();

    handler.initDB().whenComplete(() {
      entrySum = getEntrySum();
    });

    handler.initDB().whenComplete(() {
      exitSum = getExitSum();
    });

    super.initState();
  }

  Future<double> getEntrySum() {
    return handler.getEntryWeightSum();
  }

  Future<double> getExitSum() {
    return handler.getExitWeightSum();
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      entrySum = getEntrySum();
      exitSum = getExitSum();
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
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(38.0)),
              const Image(
                image: AssetImage('lib/assets/leaves.png'),
                width: 98,
              ),
              const Text("Gestão de Resíduos", style: TextStyle(fontSize: 24)),
              const Padding(padding: EdgeInsets.all(50.0)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 82,
                    width: 136,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor:
                              const Color.fromRGBO(69, 161, 134, 1)),
                      onPressed: () {},
                      child: FutureBuilder<double>(
                          future: entrySum,
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              final items = snapshot.data ?? <EntryModel>[];
                              return Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(11.0)),
                                  const Text("Entrada",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 0, 0, 0.6))),
                                  Text("$items Kg",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          fontWeight: FontWeight.bold))
                                ],
                              );
                            }
                          }),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  SizedBox(
                    height: 82,
                    width: 136,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor:
                          const Color.fromRGBO(69, 161, 134, 1)),
                      onPressed: () {},
                      child: FutureBuilder<double>(
                          future: exitSum,
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              final items = snapshot.data ?? <ExitModel>[];
                              return Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(11.0)),
                                  const Text("Saida",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 0, 0, 0.6))),
                                  Text("$items Kg",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          fontWeight: FontWeight.bold))
                                ],
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(100.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 82,
                    width: 136,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor:
                              const Color.fromRGBO(69, 161, 134, 1)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryList()),
                        ).then((_) => {_refresh()});
                      },
                      child: const Text(
                        "Listagem de Entradas",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  SizedBox(
                    height: 82,
                    width: 136,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor:
                              const Color.fromRGBO(69, 161, 134, 1)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExitList()),
                        ).then((_) => {_refresh()});
                      },
                      child: const Text(
                        "Listagem de Saidas",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
