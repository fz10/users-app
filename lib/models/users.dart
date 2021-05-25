import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final Map<String, dynamic> address;
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
  });

   


  User copyWith({
    String id,
    String name,
    String username,
    String email,
    Map<String, dynamic> address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      address: Map<String, dynamic>.from(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, email: $email, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.name == name &&
      other.username == username &&
      other.email == email &&
      mapEquals(other.address, address);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      address.hashCode;
  }
}
