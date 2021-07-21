import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';
import 'package:sweet_corn_app/theme.dart';

import 'login_bloc.dart';
import 'login_card.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 2,
              child: BlocProvider(
                  create: (context) => LoginBloc(userService: UserService()),
                  child: LoginCard()))
        ],
      ),
    );
  }
}
