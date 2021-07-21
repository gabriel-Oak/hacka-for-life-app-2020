import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sweet_corn_app/common/user_service/user_service.dart';
import 'package:sweet_corn_app/views/client/client_bloc.dart';
import 'package:sweet_corn_app/views/client/client_state.dart';
import 'package:sweet_corn_app/views/pre_login/pre_login_page.dart';

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _logout() async {
      await UserService().logout();
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: PreLogin()),
      );
    }

    return BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) => Column(children: [
              ListTile(
                  leading: CircleAvatar(child: Text(UserService.user.name[0])),
                  title: Text(UserService.user.name),
                  subtitle: Text(UserService.user.email ?? '')),
              ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sair'),
                  onTap: _logout)
            ]));
  }
}
