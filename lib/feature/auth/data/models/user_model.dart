// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MyUserModel extends Equatable {
  final String name;
  final String uid;
  final String email;
  final double balance;
  const MyUserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
      'balance': balance,
    };
  }

  factory MyUserModel.fromMap(Map<String, dynamic> map) {
    return MyUserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
      balance: map['balance'] as double,
    );
  }

  @override
  List<Object> get props => [name, uid, balance, email];
}
