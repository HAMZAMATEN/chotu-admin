import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng, String) onLocationPicked;

  LocationPicker({required this.onLocationPicked});

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _selectedLocation;
  String _address = "Select a location";

  static const LatLng _initialPosition = LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng latLng) async {
              setState(() {
                _selectedLocation = latLng;
              });

              try {
                List<Placemark> placemarks =
                await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
                if (placemarks.isNotEmpty) {
                  _address = "${placemarks.first.locality}, ${placemarks.first.country}";
                } else {
                  _address = "Address not found";
                }

                widget.onLocationPicked(latLng, _address);
              } catch (e) {
                print("Error fetching address: $e");
                _address = "Failed to fetch address";
              }
            },
            markers: _selectedLocation != null
                ? {
              Marker(markerId: MarkerId("picked"), position: _selectedLocation!)
            }
                : {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Selected Location: $_address"),
        ),
      ],
    );
  }
}
