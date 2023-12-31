import 'package:flutter/material.dart';
import 'package:neosurgetest/feature/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/screen/auth_screen.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/expense/expense_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/bloc/goal/goal_bloc.dart';
import 'package:neosurgetest/feature/home/presentation/screen/home_screen.dart';
import 'package:neosurgetest/utils/theme.dart';

class AuthStateWrapper extends StatelessWidget {
  const AuthStateWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neosurge Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme(),
      home: StreamBuilder(
        stream: AuthRepository().user,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => SignInBloc()),
                BlocProvider(create: (_) => DashboardBloc()),
                BlocProvider(create: (_) => GoalBloc()),
                BlocProvider(create: (_) => ExpenseBloc()),
              ],
              child: const HomeScreen(),
            );
          } else {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => SignUpBloc()),
                BlocProvider(create: (_) => SignInBloc()),
              ],
              child: const AuthScreen(),
            );
          }
        },
      ),
    );
  }
}
