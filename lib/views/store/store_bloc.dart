import 'package:bloc/bloc.dart';
import 'package:sweet_corn_app/views/store/store_event.dart';
import 'package:sweet_corn_app/views/store/store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {

  @override
  StoreState get initialState => StoreState();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is GoTo) {
      yield StoreState(index: event.index);
    }
  }
}
