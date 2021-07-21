import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/views/client/client_bloc.dart';
import 'package:sweet_corn_app/views/client/client_event.dart';
import 'package:sweet_corn_app/views/client/client_state.dart';
import 'package:sweet_corn_app/views/store/counter/counter_page.dart';
import 'package:sweet_corn_app/views/store/profile/profile_page.dart';

class StoreContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _goTo(index) =>
        BlocProvider.of<ClientBloc>(context).add(GoTo(index: index));

    return BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) => Scaffold(
            body: IndexedStack(
                index: state.index,
                children: [CounterPage(), ProfilePage()]),
            bottomNavigationBar: BottomNavigationBar(
                onTap: _goTo,
                currentIndex: state.index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.map), title: Text('Mapa')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('Perfil'))
                ])));
  }
}
