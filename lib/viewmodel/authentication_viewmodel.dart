import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment/model/user_model.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';

class AuthenticationViewmodel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _authenticationLoading = false;
  bool get authenticationLoading => _authenticationLoading;

  AuthenticationViewmodel() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
  }

  Future<bool?> loginWithEmail(String email, String password) async {
    try {
      _authenticationLoading = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _authenticationLoading = false;
      return true;
    } on FirebaseAuthException catch (e) {
      _authenticationLoading = false;
      _errorMessage = e.message ?? 'An unknown error occurred';
      notifyListeners();
      return false;
    }
  }

  Future<bool?> register(
      String firstName, String lastName, String email, String password) async {
    try {
      _authenticationLoading = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = _auth.currentUser!.uid;
      UserModel user = UserModel(
        id: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      await _firestore.collection('users').doc(uid).set(user.toJson());
      _authenticationLoading = false;
      return true;
    } on FirebaseAuthException catch (e) {
      _authenticationLoading = false;
      _errorMessage = e.message ?? 'An unknown error occurred';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool _emailError = false;
  bool _passwordError = false;
  bool _firstNameError = false;
  bool _lastNameError = false;

  bool get emailError => _emailError;
  bool get passwordError => _passwordError;
  bool get firstNameError => _firstNameError;
  bool get lastNameError => _lastNameError;

  void validateFirstName(String? name) {
    if (name == null || name.isEmpty) {
      _firstNameError = true;
    } else {
      _firstNameError = false;
    }
    notifyListeners();
  }

  void validateLastName(String? name) {
    if (name == null || name.isEmpty) {
      _lastNameError = true;
    } else {
      _lastNameError = false;
    }
    notifyListeners();
  }

  void validateEmail(String? value) {
    _emailError = value == null ||
        value.isEmpty ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
    notifyListeners();
  }

  void validatePassword(String? value) {
    _passwordError = value == null || value.isEmpty || value.length < 6;
    notifyListeners();
  }

  bool validateForm(String? email, String? password) {
    validateEmail(email);
    validatePassword(password);
    return !_emailError && !_passwordError;
  }

  // logout
  Future<void> logout(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )));
      await _auth.signOut();
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      log("User logged out successfully");
    } catch (e) {
      Navigator.pop(context);
      log("Error while logging out: ${e.toString()}");
    }
  }
}
