import 'dart:convert';

import 'package:flutter_delivery/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? password;
  String? sessionToken;
  List<Rol>? roles = [];

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.password,
    this.sessionToken,
    this.roles
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    password: json["password"],
    sessionToken: json["session_token"],
    roles: (json["roles"] == null
        ? []
        : (json["roles"] as List<dynamic>)
        .map((model) => Rol.fromJson(model))
        .toList()) ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "password": password,
    "session_token": sessionToken,
    "roles": roles
  };
}
