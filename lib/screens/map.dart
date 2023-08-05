import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// for showing google maps on screen
import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
      // by default kept Google, CA office location
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  // location we are getting from place_detail.dart
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick yor location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                // automatically stores in position the position where we tapped
                setState(() {
                  _pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          // initial position of map's camera
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            //{} means empty set
            : {
                // set
                Marker(
                  // we are showing a marker on screen
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        // ?? means if _pickedLocation is not null then the value of variable should be _pickedLocation, other wise LatLng()
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
