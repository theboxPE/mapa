import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mapa/input.dart';

void main() {
  // Inicializar GeocodingPlatform
  GeocodingPlatform.instance;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InputScreen(),
    );
  }
}