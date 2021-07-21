import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweet_corn_app/views/client/details/details_page.dart';

import 'map_event.dart';
import 'map_service.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapService service = MapService();

  @override
  MapState get initialState => MapState(loading: true);

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is GetUserLocation) {
      final userLocation = await _getLocation();
      print('userLocation');
      print(userLocation);

      yield state.copyWith(userLocation: userLocation);
    } else if (event is GetNearbyStores) {
      yield state.copyWith(loading: true);
      try {
        final res = await service.getNearbyStores(
          userLocation: event.userLocation,
          search: event.search,
        );
        final markers = _getMarkers(res, event.context);
        yield state.copyWith(stores: res, markers: markers, loading: false);
      } catch (e) {
        yield state.copyWith(errorMessage: e.toString(), loading: false);
      }
    } else if (event is ClearErrorMessage) {
      yield state.copyWith(errorMessage: null);
    }
  }

  Future _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Map<MarkerId, Marker> _getMarkers(List stores, BuildContext context) {
    Map<MarkerId, Marker> markers = {};

    stores.forEach((item) {
      final markerId = MarkerId('${item['uuid']}');
      final marker = Marker(
        markerId: markerId,
        position: LatLng(item['latitude'], item['longitude']),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.upToDown,
              child: DetailsPage(store: item),
            ),
          );
        },
      );
      markers[markerId] = marker;
    });

    return markers;
  }
}
