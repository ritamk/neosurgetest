import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosurgetest/feature/auth/domain/repo/auth_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SigninUp>((event, emit) async {
      emit(SignUpProcessing());
      try {
        await AuthRepository()
            .registerWithMailPass(event.name, event.mail, event.password);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
