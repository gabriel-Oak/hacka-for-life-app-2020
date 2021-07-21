import 'package:meta/meta.dart';

abstract class ClientEvent {
  ClientEvent([List props = const []]);
}

class GoTo extends ClientEvent {
  final int index;

  GoTo({@required this.index});
}
