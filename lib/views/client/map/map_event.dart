import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

abstract class MapEvent {
  MapEvent([List props = const []]);
}

class GetNearbyStores extends MapEvent {
  final Position userLocation;
  final BuildContext context;
  final String search;

  GetNearbyStores({
    @required this.userLocation,
    @required this.context,
    this.search = '',
  });
}

class GetUserLocation extends MapEvent {}

class ClearErrorMessage extends MapEvent {}
