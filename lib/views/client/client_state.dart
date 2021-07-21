import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ClientState extends Equatable {
  final int index;

  ClientState({
    this.index = 0,
  });

  @override
  List<Object> get props => [index];
}
