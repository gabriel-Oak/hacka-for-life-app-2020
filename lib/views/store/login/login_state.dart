import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'check_user_model.dart';

@immutable
class LoginState extends Equatable {
  final bool loading;
  final CheckUserModel checkUser;
  final String message;
  final int currentPage;
  final bool logged;
  final bool showPass;

  LoginState({
    this.loading = false,
    this.checkUser,
    this.message,
    this.currentPage = 0,
    this.logged = false,
    this.showPass = false,
  });

  LoginState copyWith(
      {bool loading,
      CheckUserModel checkUser,
      String message,
      int currentPage,
      bool logged,
        bool showPass}) {
    return LoginState(
      loading: loading == null ? this.loading : loading,
      checkUser: checkUser ?? this.checkUser,
      message: message,
      currentPage: currentPage ?? this.currentPage,
      logged: logged == null ? this.logged : logged,
      showPass: showPass == null ? this.showPass : showPass,
    );
  }

  @override
  List<Object> get props => [loading, checkUser, message, currentPage, logged, showPass];
}
