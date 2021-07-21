import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
class MapState extends Equatable {
  final bool loading;
  final List stores;
  final Position userLocation;
  final String errorMessage;
  final Map<MarkerId, Marker> markers;

  MapState({
    this.loading = false,
    this.stores,
    this.userLocation,
    this.errorMessage,
    this.markers,
  });

  MapState copyWith({
    bool loading,
    List stores,
    Position userLocation,
    String errorMessage,
    Map<MarkerId, Marker> markers,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      stores: stores ?? this.stores,
      userLocation: userLocation ?? this.userLocation,
      errorMessage: errorMessage ?? this.errorMessage,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [
        loading,
        stores,
        userLocation,
        errorMessage,
        markers,
      ];
}
