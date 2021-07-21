import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweet_corn_app/theme.dart';
import 'package:sweet_corn_app/views/client/client_page.dart';
import 'package:sweet_corn_app/views/store/login/login_page.dart';

class PreLogin extends StatelessWidget {
  _goToLogin(context) {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.downToUp, child: LoginPage()),
    );
  }

  _goToMap(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(child: ClientPage(), type: PageTransitionType.downToUp),
        ModalRoute.withName('/root'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: FlatButton(
                            child: Text('SOU CONSUMIDOR',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            onPressed: () => _goToMap(context))),
                    Padding(padding: EdgeInsets.only(top: 16)),
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child: Container(
                            height: 56,
                            child: RaisedButton(
                                child: Text('SOU LOJISTA',
                                    style: TextStyle(
                                        fontSize: 18, color: primaryColor)),
                                onPressed: () => _goToLogin(context))))
                  ])))
    ]);
  }
}
