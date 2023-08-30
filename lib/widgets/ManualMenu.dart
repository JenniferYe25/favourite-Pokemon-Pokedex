import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/models/pokemon.dart';
import 'package:test_app2/screens/add.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/pokemon_cubit.dart';

class ManualMenuState extends State<ManualMenu> {
  final _formKey = GlobalKey<FormState>();

  final typeList = <PokemonType>[];
  final selectedTypes = <PokemonType>{};

  bool value = false;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    heightController.dispose();
    weightController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    typeList.addAll(PokemonType.values);
  }

  File _image = File('/Users/jenniferye/TestApp/test_app2/assets/pokeball.png');
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  static const double fontsize = 25.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 60, 40),
              child: Column(
                children: [
                  const Text("Picture", style: TextStyle(fontSize: fontsize)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => getImage(),
                        child: CircleAvatar(
                          radius: 70,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    '/Users/jenniferye/TestApp/test_app2/assets/pokeball.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text("Info", style: TextStyle(fontSize: fontsize)),
                  TextFormField(
                    validator: ((String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Pokémon name';
                      }
                      return null;
                    }),
                    controller: nameController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.catching_pokemon),
                        hintText: "Name",
                        labelText: "Who's that Pokémon"),
                  ),
                  TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Pokédex number';
                      } else if (int.parse(value) < 903) {
                        return 'This number is already taken';
                      }
                      return null;
                    }),
                    controller: numberController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.numbers), hintText: "National Number"),
                  ),
                  TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a height in meters';
                        } else if (int.parse(value) < 0) {
                          return 'Pokemon cannot be negative height';
                        }
                        return null;
                      }),
                      controller: heightController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.height),
                        hintText: "Height",
                      )),
                  TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a weight in kg';
                        } else if (int.parse(value) < -1) {
                          return 'Pokemon cannot be negative weight';
                        }
                        // else if(value.contains(other))
                        return null;
                      }),
                      controller: weightController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.monitor_weight),
                        hintText: "Weight",
                      )),
                ],
              ),
            ),
            const Text("Type", style: TextStyle(fontSize: fontsize)),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 20),
              child: Table(
                children: typeList
                    .chunkBy<PokemonType>(2)
                    .map(
                      (g) => TableRow(
                        children: g
                            .map(
                              (k) => CheckboxListTile(
                                value: selectedTypes.contains(k),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true &&
                                        selectedTypes.length < 2) {
                                      selectedTypes.add(k);
                                    } else {
                                      selectedTypes.remove(k);
                                    }
                                  });
                                },
                                title: Text(k.displayName),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pokémon description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Generating new Pokemon stats...'),
                      ),
                    );
                    final data = Pokemon(
                      name: nameController.text,
                      number: int.parse(numberController.text),
                      types: selectedTypes.toList(),
                      weight: double.parse(weightController.text),
                      height: double.parse(heightController.text),
                      custom: _image,
                      description: descriptionController.text,
                    );
                    context.read<PokemonCubit>().add(data);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Finish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
