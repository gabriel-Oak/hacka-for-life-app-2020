import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/common/socket.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';
import 'package:sweet_corn_app/views/store/counter/counter_bloc.dart';
import 'package:sweet_corn_app/views/store/counter/counter_event.dart';
import 'package:sweet_corn_app/views/store/counter/counter_state.dart';

class CounterContent extends StatefulWidget {
  @override
  _CounterContentState createState() => _CounterContentState();
}

class _CounterContentState extends State<CounterContent> {
  @override
  void initState() {
    BlocProvider.of<CounterBloc>(context).add(GetInfo());
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

      Socket.socket.emit('setStore', {'idStore': UserService.user.uuid});

      Socket.socket.on('update', (data) {
        BlocProvider.of<CounterBloc>(context).add(GetInfo());
        print('update $data');
      });
    });
  }

  _add() {
    BlocProvider.of<CounterBloc>(context).add(Add());
  }

  _remove() {
    BlocProvider.of<CounterBloc>(context).add(Remove());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
      return Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('LIMITE: ${state.maxNumberPeople.toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.w500)),
                            Text(state.nowNumberPeople.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.3,
                                    color: state.nowNumberPeople >
                                            state.maxNumberPeople
                                        ? Colors.red
                                        : Colors.white)),
                            Text('AGORA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    fontWeight: FontWeight.w300))
                          ])),
                ),
                Positioned(
                    left: 16,
                    top: MediaQuery.of(context).size.width * 0.8 + 48,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 30,
                        child: IconButton(
                            onPressed: _remove,
                            color: Colors.red,
                            icon: Icon(Icons.remove)))),
                Positioned(
                    right: 16,
                    top: MediaQuery.of(context).size.width * 0.8 + 48,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 30,
                        child: IconButton(
                            onPressed: _add,
                            color: Colors.green,
                            icon: Icon(Icons.add)))),
              ])));
    });
  }
}
