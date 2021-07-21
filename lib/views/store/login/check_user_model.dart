import 'package:flutter/cupertino.dart';

class CheckUserModel {
  final String name;
  final String email;

  CheckUserModel(
      {@required this.name, @required this.email});

  factory CheckUserModel.fromJSON(Map<String, dynamic> json) {
    return CheckUserModel(
      name: json['name'],
      email: json['email'],
    );
  }
}
