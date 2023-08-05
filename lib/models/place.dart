import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
// creating a uuid variable by instantiating it. It is used to give unique id to each Place() object

class PlaceLocation {
  const PlaceLocation({
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();
  // using the v4 funation of uuid to automatically generate random unique id's
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
