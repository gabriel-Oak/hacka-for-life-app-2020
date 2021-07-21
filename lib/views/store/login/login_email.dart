import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginEmail extends StatefulWidget {
  final TextEditingController email;

  LoginEmail({@required this.email});

  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final formEmail = GlobalKey<FormState>();

  String Function(String value) validadeEmail = (String value) {
    if (value.isEmpty) return 'Digite seu e-mail';
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: 249,
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) => Column(children: <Widget>[
                              Form(
                                  key: formEmail,
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Digite seu e-mail',
                                          errorText: state.message),
                                      controller: widget.email,
                                      validator: validadeEmail)),
                              Padding(padding: const EdgeInsets.only(top: 32)),
                              SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: RaisedButton(
                                      child: Text(state.loading
                                          ? 'CARREGANDO...'
                                          : 'AVANÇAR'),
                                      onPressed: !state.loading
                                          ? () {
                                              if (formEmail.currentState
                                                  .validate())
                                                BlocProvider.of<LoginBloc>(
                                                        context)
                                                    .add(CheckEmail(
                                                        email:
                                                            widget.email.text));
                                            }
                                          : null,
                                      elevation: 0))
                            ]))))));
  }
}
