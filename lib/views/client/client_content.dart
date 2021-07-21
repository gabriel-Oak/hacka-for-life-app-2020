import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/views/client/client_bloc.dart';
import 'package:sweet_corn_app/views/client/client_state.dart';

import 'map/map_page.dart';

class ClientContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) => Scaffold(
            body: MapPage()));
  }
}
