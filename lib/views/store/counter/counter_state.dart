import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class CounterState extends Equatable {
  int nowNumberPeople;
  int maxNumberPeople;

  CounterState({
    this.nowNumberPeople = 0,
    this.maxNumberPeople = 0,
  });

  @override
  List<Object> get props => [nowNumberPeople, maxNumberPeople];
}
