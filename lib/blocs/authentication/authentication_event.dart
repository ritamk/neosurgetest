// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged({this.user});

  final User? user;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
