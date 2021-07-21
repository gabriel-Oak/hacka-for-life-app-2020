import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_bloc.dart';
import 'map_content.dart';
import 'map_event.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MapBloc()..add(GetUserLocation()),
        child: SafeArea(child: MapContent()),
      ),
    );
  }
}
