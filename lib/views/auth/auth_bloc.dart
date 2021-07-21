import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';

import 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserService userService;

  AuthBloc({@required this.userService});

  @override
  AuthState get initialState => AuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Started) {
      final user = await this.userService.read();
      UserService.user = user;
      if (user == null)
        yield state.copyWith(stateAuth: StateAuth.initial);
      else
        yield state.copyWith(stateAuth: StateAuth.logged);
    }
  }
}
