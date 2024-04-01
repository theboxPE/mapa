import 'package:flutter/material.dart';


class MapScreen extends StatelessWidget {
  final String? name;
  final String? lastName;
  final double? latitude;
  final double? longitude;
  final String? address; // Añadida la dirección

  const MapScreen({
    super.key, // Corregido el parámetro key
    this.name,
    this.lastName,
    this.latitude,
    this.longitude,
    this.address, // Añadida la dirección
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${name ?? ''} ${lastName ?? ''}'),
            const SizedBox(height: 10),
            Text('Coordenadas: (${latitude ?? 0}, ${longitude ?? 0})'),
            const SizedBox(height: 10),
            Text('Dirección: ${address ?? 'Dirección no disponible'}'), // Mostrar la dirección
          ],
        ),
      ),
    );
  }
}