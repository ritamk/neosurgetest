import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neosurgetest/feature/auth/domain/repo/auth_repo.dart';
import 'package:neosurgetest/utils/shared_pref.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SigningIn>((event, emit) async {
      emit(SignInProcessing());
      try {
        final uid =
            await AuthRepository().signInWithMailPass(event.mail, event.pass);
        await LocalSharedPref.setUid(uid!);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(e.toString()));
      }
    });

    on<SigningOut>((event, emit) async {
      await LocalSharedPref.clearSharedPref();
      await AuthRepository().signOut();
    });
  }
}
