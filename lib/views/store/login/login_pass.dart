import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPass extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController pass;

  LoginPass({@required this.email, @required this.pass});

  @override
  _LoginPassState createState() => _LoginPassState();
}

class _LoginPassState extends State<LoginPass> {
  final formPass = GlobalKey<FormState>();

  String Function(String value) validadePass = (String value) {
    if (value.isEmpty) return 'Digite sua senha';
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: double.infinity,
            height: 340,
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () =>
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(SetPage(page: 0))),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                          child: Text(
                                              state.checkUser.name != null
                                                  ? state.checkUser.name[0]
                                                  : '')),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                              state.checkUser.name != null
                                                  ? state.checkUser.name
                                                  : '',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black54)))
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center)),
                            Form(
                                key: formPass,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Digite sua senha',
                                        errorText: state.message,
                                        suffixIcon: IconButton(
                                          icon: Icon(!state.showPass
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () =>
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(TooglePass()),
                                        )),
                                    validator: validadePass,
                                    obscureText: !state.showPass,
                                    controller: widget.pass)),
                            Padding(padding: const EdgeInsets.only(top: 32)),
                            SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: RaisedButton(
                                    child: Text(state.loading
                                        ? 'CARREGANDO...'
                                        : 'ENTRAR'),
                                    onPressed: state.loading
                                        ? null
                                        : () {
                                            if (formPass.currentState
                                                .validate())
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(SingIn(
                                                      email: widget.email.text,
                                                      password:
                                                          widget.pass.text));
                                          },
                                    elevation: 0))
                          ]);
                    })))));
  }
}
