abstract class CounterEvent {
  CounterEvent([List props = const []]);
}

class GetInfo extends CounterEvent {}

class Add extends CounterEvent {}

class Remove extends CounterEvent {}
