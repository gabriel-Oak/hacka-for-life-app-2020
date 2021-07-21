import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_corn_app/views/client/client_bloc.dart';

import 'client_content.dart';

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientBloc(),
      child: ClientContent(),
    );
  }
}
