import 'package:firebase_auth/firebase_auth.dart';
import 'package:neosurgetest/feature/home/domain/repo/db_repo.dart';
import 'package:neosurgetest/feature/auth/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((event) => event);
  }

  Future<String?> signInWithMailPass(String mail, String pass) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);

      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return null;
      } else {
        throw "Something went wrong (${e.code})";
      }
    }
  }

  Future<String?> registerWithMailPass(
      String name, String mail, String pass) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      final User? user = userCredential.user;

      if (user != null) {
        await DatabaseRepository().setUserData(MyUserModel(
          uid: user.uid,
          name: name,
          email: mail,
          balance: 0,
        ));
      }
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw "Something went wrong (${e.code})";
    }
  }

  Future<bool?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw "Something went wrong (${e.code})";
    }
  }

  Future<String?> currentUid() async {
    try {
      return _firebaseAuth.currentUser?.uid;
    } on FirebaseAuthException catch (e) {
      throw "Something went wrong (${e.code})";
    }
  }
}
