import 'package:meta/meta.dart';

abstract class LoginEvent {
  LoginEvent([List props = const []]);
}

class CheckEmail extends LoginEvent {
  String email;

  CheckEmail({@required this.email});
}

class SetPage extends LoginEvent {
  int page;

  SetPage({@required this.page});
}

class SingIn extends LoginEvent {
  String email;
  String password;

  SingIn({@required this.email, @required this.password});
}

class TooglePass extends LoginEvent {}
