import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  

  UserState() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}