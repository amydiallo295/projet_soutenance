import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashscreenModel = ChangeNotifierProvider((ref) => SplashscreenModel());

class SplashscreenModel extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
