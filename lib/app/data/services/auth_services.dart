import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/failures.dart';

class AuthServices extends GetxService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthServices(this._auth, this._googleSignIn);

  Future<Either<InfraFailure, User>> login(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (cred.user != null) {
        return right(cred.user!);
      } else {
        return left(const InfraFailure.unexpected());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const InfraFailure.userNotFound());
      }
      return left(InfraFailure.serverError(
        errorMessage: e.message ?? "Server error",
      ));
    }
  }

  Future<Either<InfraFailure, User>> signup(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        return right(cred.user!);
      } else {
        return left(const InfraFailure.unexpected());
      }
    } on FirebaseAuthException catch (e) {
      return left(InfraFailure.serverError(
        errorMessage: e.message ?? "Server error",
      ));
    }
  }

  bool get isLoggedIn {
    return _auth.currentUser != null;
  }

  Stream<User?> get listenForAuthStateChange {
    return _auth.authStateChanges();
  }

  Future<void> logOut() async {
    await _auth.signOut();
    _googleSignIn.signOut();
  }

  User getCurrentUser() {
    return _auth.currentUser!;
  }

  Future<Either<InfraFailure, Unit>> loginWithGoogle() async {
    try {
      final result = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await result?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(InfraFailure.serverError(
        errorMessage: e.message ?? "Server error",
      ));
    }
    // _auth.
  }
}
