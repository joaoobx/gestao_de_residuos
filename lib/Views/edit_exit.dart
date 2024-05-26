import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/JsonModels/exit_model.dart';
import 'package:gerenciamento_de_residuos/SQLite/sqlite.dart';

class EditExit extends StatefulWidget {
  final int? editExitId;
  final String editType;
  final String editLocation;
  final double editWeight;
  final String editSupplier;
  final String editMtr;
  final String editCdf;
  final double editRevenue;
  final double editCost;
  const EditExit(
      {super.key,
        required this.editExitId,
        required this.editType,
        required this.editLocation,
        required this.editWeight,
        required this.editSupplier,
        required this.editMtr,
        required this.editCdf,
        required this.editRevenue,
        required this.editCost});

  @override
  State<EditExit> createState() => _EditExitState();
}

class _EditExitState extends State<EditExit> {
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
                const Text("Edição de Saida", style: TextStyle(fontSize: 24)),
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
                            decoration: InputDecoration(
                              label: Text(widget.editType),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editLocation),
                              labelStyle: const TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editWeight.toString()),
                              labelStyle: const TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editSupplier),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editCost.toString()),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editRevenue.toString()),
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editMtr),
                              labelStyle: const TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                            decoration: InputDecoration(
                              label: Text(widget.editCdf),
                              labelStyle: const TextStyle(color: Colors.black),
                              fillColor: Colors.black,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                                      .updateExit(
                                      type.text,
                                      location.text,
                                      double.parse(weight.text),
                                      supplier.text,
                                      mtr.text,
                                      cdf.text,
                                      double.parse(revenue.text),
                                      double.parse(cost.text),
                                      widget.editExitId)
                                      .whenComplete(() {
                                    //When this value is true
                                    Navigator.of(context).pop(true);
                                  });
                                }
                              },
                              child: const Text(
                                "Editar",
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
