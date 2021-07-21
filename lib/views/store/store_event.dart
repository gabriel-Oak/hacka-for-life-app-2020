import 'package:meta/meta.dart';

abstract class StoreEvent {
  StoreEvent([List props = const []]);
}

class GoTo extends StoreEvent {
  final int index;

  GoTo({@required this.index});
}
