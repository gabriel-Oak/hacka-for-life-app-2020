import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState extends Equatable {
  final int index;

  ProfileState({
    this.index = 0,
  });

  @override
  List<Object> get props => [index];
}
