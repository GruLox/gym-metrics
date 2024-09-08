import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  String get username => _auth.currentUser?.displayName ?? 'No username';
  

  UserState() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(String username, String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      await credential.user?.updateDisplayName(username);
      await credential.user?.reload();
    }
  }



  Future<void> signOut() async {
    await _auth.signOut();
  }
}