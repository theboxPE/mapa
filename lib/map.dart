import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatelessWidget {
  final String? name;
  final String? lastName;
  final double? latitude;
  final double? longitude;

  const MapScreen({
    super.key,
    this.name,
    this.lastName,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude ?? 0, longitude ?? 0),
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('userLocation'),
            position: LatLng(latitude ?? 0, longitude ?? 0),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nombre: ${name ?? ''} ${lastName ?? ''}'),
                        const SizedBox(height: 10),
                        FutureBuilder<String>(
                          future: _getAddressFromLatLng(latitude ?? 0, longitude ?? 0),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error al obtener la ubicación');
                            } else {
                              return Text('Ubicación: ${snapshot.data ?? ''}');
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        },
      ),
    );
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark first = placemarks.first;
      return '${first.locality ?? ''}, ${first.country ?? ''}';
    } catch (e) {
      Text('Error al obtener la dirección: $e');
      return 'Dirección no disponible';
    }
  }
}