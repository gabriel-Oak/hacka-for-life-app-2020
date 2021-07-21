import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/views/client/client_bloc.dart';

import 'profile_content.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: BlocProvider(
        create: (context) => ClientBloc(),
        child: ProfileContent(),
      ),
    );
  }
}
