import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/common/socket.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';
import 'package:sweet_corn_app/views/store/counter/counter_bloc.dart';
import 'package:sweet_corn_app/views/store/counter/counter_content.dart';
import 'package:sweet_corn_app/views/store/counter/counter_event.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  void initState() {
    connect();
    super.initState();
  }

  @override
  void dispose() {
    Socket.socket.disconnect();
    super.dispose();
  }

  connect() async {
    Socket.socket.connect();

    Socket.socket.on('connect', (data) {
      print('connect ${data.toString()}');

      Socket.socket
          .emit('setStore', {'idStore': UserService.user.uuid});

      Socket.socket.on('update', (data) {
        print('update $data');
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => CounterBloc()..add(GetInfo()),
            child: CounterContent()
        ));
  }
}
