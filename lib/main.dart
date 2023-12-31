import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neosurgetest/firebase_options.dart';
import 'package:neosurgetest/utils/shared_pref.dart';
import 'package:neosurgetest/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalSharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthStateWrapper();
  }
}
