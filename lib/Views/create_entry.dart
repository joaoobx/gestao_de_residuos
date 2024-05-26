import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';

class CreateEntry extends StatefulWidget {
  const CreateEntry({super.key});

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final type = TextEditingController();
  final weight = TextEditingController();
  final location = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, maxHeight: double.infinity),
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
                const Image(
                  image: AssetImage('lib/assets/leaves.png'),
                  width: 98,
                ),
                const Padding(padding: EdgeInsets.all(20.0)),
                const Text("Nova Entrada", style: TextStyle(fontSize: 24)),
                Form(
                  //I forgot to specify key
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: type,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se informar um tipo";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Classe"),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          TextFormField(
                            controller: location,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar uma localização";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Localização"),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(10.0)),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: weight,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Peso"),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(30.0)),
                          SizedBox(
                            height: 41,
                            width: 360,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(90)),
                                  backgroundColor:
                                  const Color.fromRGBO(69, 161, 134, 1),
                                  padding: const EdgeInsets.all(0.0)),
                              onPressed: () {
                                //Add Note button
                                //We should not allow empty data to the database
                                if (formKey.currentState!.validate()) {
                                  db
                                      .createEntry(EntryModel(
                                      type: type.text,
                                      location: location.text,
                                      weight: double.parse(weight.text),
                                      createdAt: DateTime.now().toIso8601String()))
                                      .whenComplete(() {
                                    //When this value is true
                                    Navigator.of(context).pop(true);
                                  });
                                }
                              },
                              child: const Text(
                                "Cadastrar entrada",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            )))
        );
  }
}
