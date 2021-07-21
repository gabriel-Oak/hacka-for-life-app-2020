import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sweet_corn_app/common/user_service/user_model.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';

import '../../../constraints.dart';
import 'check_user_model.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;

  LoginBloc({@required this.userService});

  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SingIn) {
      try {
        print(event);
        yield state.copyWith(loading: true);
        final dio = new Dio();
        final res = await dio.post('$kApi/store/auth',
            data: {'email': event.email, 'pass': event.password});
        print(res.data);
        await userService.save(
            name: state.checkUser.name,
            email: state.checkUser.email,
            uuid: res.data['store']['uuid'],
            token: res.data['token']);
        UserService.user = User(
            name: state.checkUser.name,
            email: state.checkUser.email,
            uuid: res.data['store']['uuid'],
            token: res.data['token']);
        yield state.copyWith(loading: false, logged: true);
      } on DioError catch (e) {
        if (e.response.statusCode == 404)
          yield state.copyWith(loading: false, message: 'Senha inválida');
        else
          yield state.copyWith(
              loading: false,
              message: 'Tivemos um problema, tente novamente mais tarde');
      } catch (e) {
        yield state.copyWith(
            loading: false,
            message: 'Tivemos um problema, tente novamente mais tarde');
      }
    }

    if (event is CheckEmail) {
      try {
        yield state.copyWith(loading: true);
        final dio = new Dio();
        final res = await dio
            .get('$kApi/store/check', queryParameters: {'email': event.email});
        final checkUser = CheckUserModel.fromJSON(res.data);
        yield state.copyWith(
            loading: false, checkUser: checkUser, currentPage: 1);
      } on DioError catch (e) {
        print(e);
        print(e.response);
        if (e.response.statusCode == 404)
          yield state.copyWith(
              loading: false, message: 'E-mail não encontrado');
        else
          yield state.copyWith(
              loading: false,
              message: 'Tivemos um problema, tente novamente mais tarde');
      } catch (e) {
        yield state.copyWith(
            loading: false,
            message: 'Tivemos um problema, tente novamente mais tarde');
      }
    }

    if (event is SetPage) {
      yield state.copyWith(currentPage: event.page);
    }

    if (event is TooglePass) {
      yield state.copyWith(message: state.message, showPass: !state.showPass);
    }
  }
}
