import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashscreenModel = ChangeNotifierProvider((ref) => SplashscreenModel());

class SplashscreenModel extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> loadCurrentUser() async {
    if (_currentUser != null) {
      return;
    }
    _currentUser = FirebaseAuth.instance.currentUser;
  }
}
