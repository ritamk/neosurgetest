import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosurgetest/feature/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:neosurgetest/utils/button.dart';
import 'package:neosurgetest/utils/snackbar.dart';
import 'package:neosurgetest/utils/text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _passFocus = FocusNode();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  bool _hidePass = true;

  bool _signingUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        switch (state) {
          case SignUpSuccess():
            setState(() => _signingUp = false);
          case SignUpProcessing():
            setState(() => _signingUp = true);
          case SignUpFailure():
            setState(() => _signingUp = false);
            customSnackbar(context, content: 'Sign up failed', isError: true);
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
                        label: 'Name',
                        focus: _nameFocus,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your name";
                          } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(val)) {
                            return "Please enter a valid name";
                          }
                          return null;
                        },
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
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
                            context.read<SignUpBloc>().add(SigninUp(
                                  name: _nameController.text.trim(),
                                  mail: _mailController.text.trim(),
                                  password: _passController.text.trim(),
                                ));
                          }
                        },
                        label: _signingUp ? null : 'Sign up',
                        child: _signingUp
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
    _nameController.dispose();
    _nameFocus.dispose();
    _mailController.dispose();
    _mailFocus.dispose();
    _passController.dispose();
    _passFocus.dispose();
    super.dispose();
  }
}
