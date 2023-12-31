import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:neosurgetest/feature/auth/presentation/screen/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign In',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Creates border
              color: Colors.green.shade700,
            ),
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.white,
            labelStyle: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily, fontSize: 16),
            tabs: const [
              Tab(text: 'Sign up'),
              Tab(text: 'Sign in'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
                create: (_) => SignUpBloc(), child: const SignUpScreen()),
            BlocProvider(
                create: (_) => SignInBloc(), child: const SignInScreen()),
          ],
        ),
      ),
    );
  }
}
