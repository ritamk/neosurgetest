// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SigninUp extends SignUpEvent {
  const SigninUp({
    required this.name,
    required this.mail,
    required this.password,
  });

  final String name;
  final String mail;
  final String password;
}
