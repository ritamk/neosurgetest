import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:neosurgetest/api/auth_repo.dart';
import 'package:neosurgetest/screens/auth/ui/sign_up_screen.dart';
import 'package:neosurgetest/screens/home/ui/home_screen.dart';
import 'package:neosurgetest/utils/shared_pref.dart';

class AuthStateWrapper extends StatelessWidget {
  const AuthStateWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthRepository().user,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          LocalSharedPref.setUid(snapshot.data.uid);
          return const SignUpScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
