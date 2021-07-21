import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  final Map<String, dynamic> store;
  final Function onTap;

  MapCard({@required this.store, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String distance = store['distance'] < 1
        ? '${(store['distance'] * 1000).round().toString()} metros'
        : '${store['distance'].round().toString()} kilometros';

    return ListTile(
      onTap: onTap,
      title: Text(store['name']),
      leading: Container(
          width: 48,
          height: 48,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text((store['distance'] as double).toStringAsFixed(1).toString(),
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            Text('Km')
          ])),
      trailing: Container(
          width: 48,
          height: 48,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text((store['nowNumberPeople'] as int).toString(),
                style: TextStyle(
                    color: store['nowNumberPeople'] > store['maxNumberPeople']
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            Text('MAX: ${(store['maxNumberPeople'] as int).toString()}',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12)),
          ])),
    );
  }
}
