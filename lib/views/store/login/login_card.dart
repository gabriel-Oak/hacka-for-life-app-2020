import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../store_page.dart';
import 'login_bloc.dart';
import 'login_email.dart';
import 'login_pass.dart';
import 'login_state.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.logged)
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(child: StorePage(), type: PageTransitionType.downToUp),
                ModalRoute.withName('/root'));
        },
        child: BlocListener<LoginBloc, LoginState>(
            condition: (previousState, state) {
              return previousState.currentPage != state.currentPage;
            },
            listener: (context, state) {
              pageController.animateToPage(state.currentPage,
                  duration: Duration(milliseconds: 180), curve: Curves.ease);
            },
            child: Container(
                width: double.infinity,
                height: 370,
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      LoginEmail(email: email),
                      LoginPass(email: email, pass: pass)
                    ]))));
  }
}
