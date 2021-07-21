import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable implements Object {
  final String uuid;
  final String name;
  final String email;
  final String token;

  User.fromJSON(Map<String, dynamic> json)
      : this.uuid = json['uuid'],
        this.name = json['name'],
        this.email = json['email'],
        this.token = json['token'];

  User({this.name, this.email, this.uuid, this.token});

  @override
  String toString() {
    return 'User $name';
  }

  @override
  List<Object> get props => [name, email, uuid, token];
}
