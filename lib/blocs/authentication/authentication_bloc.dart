import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neosurgetest/api/auth_repo.dart';
import 'package:neosurgetest/blocs/authentication/authentication_state.dart';

part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required AuthRepository myAuthRepository})
      : authRepository = myAuthRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
