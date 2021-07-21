import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';

import '../../../constraints.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CounterState();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is GetInfo) {
      final dio = new Dio();
      final res = await dio.get('$kApi/store/me',
          options: Options(headers: {'authorization': UserService.user.token}));

      yield CounterState(
          maxNumberPeople: res.data['maxNumberPeople'],
          nowNumberPeople: res.data['nowNumberPeople']);
    }

    if(event is Add) {
      final dio = new Dio();

      final res = await dio.put('$kApi/store/add',
          options: Options(headers: {'authorization': UserService.user.token}));

      yield CounterState(
          maxNumberPeople: res.data['maxNumberPeople'],
          nowNumberPeople: res.data['nowNumberPeople']);
    }

    if(event is Remove) {
      final dio = new Dio();

      final res = await dio.put('$kApi/store/subtract',
          options: Options(headers: {'authorization': UserService.user.token}));

      yield CounterState(
          maxNumberPeople: res.data['maxNumberPeople'],
          nowNumberPeople: res.data['nowNumberPeople']);
    }
  }
}
