import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:neosurgetest/utils/button.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _passFocus = FocusNode();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  bool _hidePass = true;

  bool _signingIn = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        switch (state) {
          case SignInSuccess():
            setState(() => _signingIn = false);
          case SignInProcessing():
            setState(() => _signingIn = true);
          case SignInFailure():
            setState(() => _signingIn = false);
            customSnackbar(context, content: 'Sign in failed', isError: true);
          default:
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Email',
                        focus: _mailFocus,
                        controller: _mailController,
                        keyboardType: TextInputType.emailAddress,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your email";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Password',
                        focus: _passFocus,
                        controller: _passController,
                        obscure: _hidePass,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        suffix: IconButton(
                          onPressed: () =>
                              setState(() => _hidePass = !_hidePass),
                          icon: Icon(
                            _hidePass ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        validation: (val) {
                          if (val!.length < 6) {
                            return "Password must have atleast 6 characters";
                          }
                          return null;
                        },
                        inputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(SigningIn(
                                  mail: _mailController.text.trim(),
                                  pass: _passController.text.trim(),
                                ));
                          }
                        },
                        label: _signingIn ? null : 'Sign in',
                        child: _signingIn
                            ? const CupertinoActivityIndicator(
                                color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    _mailFocus.dispose();
    _passController.dispose();
    _passFocus.dispose();
    super.dispose();
  }
}
