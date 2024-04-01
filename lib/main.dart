import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationData {
  final String firstName;
  final String lastName;
  final String city;
  final double latitude;
  final double longitude;

  LocationData({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.latitude,
    required this.longitude,
  });
}

class MapScreen extends StatelessWidget {
  final LocationData locationData;

  const MapScreen({super.key, required this.locationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa - ${locationData.firstName} ${locationData.lastName}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(locationData.latitude, locationData.longitude),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(locationData.latitude, locationData.longitude),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Información del Marcador',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Nombre: ${locationData.firstName} ${locationData.lastName}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Ciudad: ${locationData.city}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Latitud: ${locationData.latitude}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Longitud: ${locationData.longitude}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cerrar',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.person_pin,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  LocationInputScreenState createState() => LocationInputScreenState();
}

class LocationInputScreenState extends State<InputScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingresar Datos de Ubicación',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
              ),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Ciudad',
              ),
            ),
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: 'Latitud',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Longitud',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final firstName = _firstNameController.text;
                final lastName = _lastNameController.text;
                final city = _cityController.text;
                final latitude = double.tryParse(_latitudeController.text);
                final longitude = double.tryParse(_longitudeController.text);

                if (firstName.isNotEmpty &&
                    lastName.isNotEmpty &&
                    latitude != null &&
                    longitude != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapScreen(
                      locationData: LocationData(
                        firstName: firstName,
                        lastName: lastName,
                        city: city,
                        latitude: latitude,
                        longitude: longitude,
                      ),
                    ),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor, complete todos los campos.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Mostrar Mapa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InputScreen(),
  ));
}