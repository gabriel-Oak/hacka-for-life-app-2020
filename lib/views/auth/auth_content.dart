import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/views/pre_login/pre_login_page.dart';
import 'package:sweet_corn_app/views/store/store_page.dart';

import 'auth.dart';

class AuthContent extends StatefulWidget {
  @override
  _AuthContentState createState() => _AuthContentState();
}

class _AuthContentState extends State<AuthContent> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.stateAuth == StateAuth.logged) _goHome();
          if (state.stateAuth == StateAuth.initial) _goLogin();
        },
        child: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) => Container()));
  }

  _goHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => StorePage()));
  }

  _goLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PreLogin()));
  }
}
