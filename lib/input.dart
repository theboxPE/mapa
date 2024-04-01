import 'package:flutter/material.dart';
import 'package:mapa/Map.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  InputScreenState createState() => InputScreenState();
}

class InputScreenState extends State<InputScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: latitudeController,
              decoration: const InputDecoration(labelText: 'Latitud'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: longitudeController,
              decoration: const InputDecoration(labelText: 'Longitud'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validación de datos
                if (nameController.text.isEmpty ||
                    lastNameController.text.isEmpty ||
                    latitudeController.text.isEmpty ||
                    longitudeController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Por favor, complete todos los campos.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Navegar a la pantalla del mapa
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        name: nameController.text,
                        lastName: lastNameController.text,
                        latitude: double.parse(latitudeController.text),
                        longitude: double.parse(longitudeController.text),
                      ),
                    ),
                  );
                }
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}