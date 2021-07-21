import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> store;

  DetailsPage({@required this.store});

  @override
  Widget build(BuildContext context) {
    final markerId = MarkerId(store['uuid']);
    final marker = Marker(
      markerId: markerId,
      position: LatLng(store['latitude'], store['longitude']),
      consumeTapEvents: false,
    );
    final distance = store['distance'] < 1
        ? '${(store['distance'] * 1000).round().toString()} metros'
        : '${store['distance'].round().toString()} kilometros';

    print(store);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(store['name'], overflow: TextOverflow.ellipsis)),
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      store['latitude'],
                      store['longitude'],
                    ),
                    zoom: 20,
                  ),
                  markers: Set.of({markerId: marker}.values),
                  myLocationEnabled: false)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
                  ListTile(
                      title: Text(store['name']),
                      subtitle: Text(store['description']),
                      trailing: Container(
                          width: 48,
                          height: 48,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    (store['distance'] as double)
                                        .toStringAsFixed(1)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Text('Km')
                              ]))),
                  Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(style: BorderStyle.solid)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              store['nowNumberPeople'].toString(),
                              style: TextStyle(
                                fontSize: 48,
                                color: store['nowNumberPeople'] >
                                        store['maxNumberPeople']
                                    ? Colors.red
                                    : Colors.blue,
                              ),
                            ),
                            Text('MAX ${store['maxNumberPeople'].toString()}'),
                          ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
