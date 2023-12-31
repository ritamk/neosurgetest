// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SigningIn extends SignInEvent {
  const SigningIn({
    required this.mail,
    required this.pass,
  });

  final String mail;
  final String pass;
}

class SigningOut extends SignInEvent {}
