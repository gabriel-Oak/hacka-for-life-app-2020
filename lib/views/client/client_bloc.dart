import 'package:bloc/bloc.dart';
import 'package:sweet_corn_app/views/client/client_event.dart';
import 'package:sweet_corn_app/views/client/client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {

  @override
  ClientState get initialState => ClientState();

  @override
  Stream<ClientState> mapEventToState(ClientEvent event) async* {
    if (event is GoTo) {
      yield ClientState(index: event.index);
    }
  }
}
