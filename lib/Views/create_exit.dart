import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/JsonModels/exit_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';

class CreateExit extends StatefulWidget {
  const CreateExit({super.key});

  @override
  State<CreateExit> createState() => _CreateExitState();
}

class _CreateExitState extends State<CreateExit> {
  final type = TextEditingController();
  final weight = TextEditingController();
  final location = TextEditingController();
  final supplier = TextEditingController();
  final mtr = TextEditingController();
  final cdf = TextEditingController();
  final revenue = TextEditingController();
  final cost = TextEditingController();
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
                const Padding(padding: EdgeInsets.all(10.0)),
                const Image(
                  image: AssetImage('lib/assets/leaves.png'),
                  width: 98,
                ),
                const Text("Nova Saida", style: TextStyle(fontSize: 24)),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
                          TextFormField(
                            controller: supplier,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Fornecedor"),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: cost,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Custo"),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: revenue,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Receita"),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
                          TextFormField(
                            controller: mtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Evidência"),
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
                          const Padding(padding: EdgeInsets.all(5.0)),
                          TextFormField(
                            controller: cdf,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Deve-se adicionar um peso";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Destinação"),
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
                                      .createExit(ExitModel(
                                      type: type.text,
                                      location: location.text,
                                      weight: double.parse(weight.text),
                                      cdf: cdf.text,
                                      cost: double.parse(cost.text),
                                      revenue: double.parse(revenue.text),
                                      mtr: mtr.text,
                                      supplier: supplier.text,
                                      createdAt: DateTime.now().toIso8601String()))
                                      .whenComplete(() {
                                    //When this value is true
                                    Navigator.of(context).pop(true);
                                  });
                                }
                              },
                              child: const Text(
                                "Cadastrar",
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
