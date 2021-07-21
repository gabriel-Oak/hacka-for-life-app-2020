import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';

import 'auth.dart';

class AuthPage extends StatefulWidget {

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => AuthBloc(userService: UserService())..add(Started()),
      child: AuthContent()
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
