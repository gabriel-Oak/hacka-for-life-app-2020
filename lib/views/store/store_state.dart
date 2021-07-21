import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class StoreState extends Equatable {
  final int index;

  StoreState({
    this.index = 0,
  });

  @override
  List<Object> get props => [index];
}
