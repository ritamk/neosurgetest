import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neosurgetest/screens/auth/ui/sign_up_screen.dart';
import 'package:neosurgetest/screens/home/ui/home_screen.dart';
import 'package:neosurgetest/utils/button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (ctx) => const HomeScreen()),
                              (route) => false,
                            );
                          }
                        },
                        label: 'Sign in',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (ctx) => const SignUpScreen()),
                  (route) => false,
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
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
