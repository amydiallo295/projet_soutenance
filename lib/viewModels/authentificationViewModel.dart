import 'package:emergency/main.dart';
import 'package:emergency/services/authentificationService.dart';
import 'package:emergency/ui/sreens/verificationode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

final authServiceProvider = Provider((ref) => AuthentificationService());

final authViewModelProvider =
    ChangeNotifierProvider((ref) => AuthViewModel(ref));

class AuthViewModel extends ChangeNotifier {
  final Ref _read;

  AuthViewModel(this._read);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityResult get connectivityResult => _connectivityResult;
  // verification de code envoyé
  Future userCodeVerifyToLogin(
      String verifyCode,
      String userName,
      String smsCode,
      String phoneNumber,
      String userPassword,
      BuildContext context) async {
    try {
      await _read
          .read(authServiceProvider)
          .signInWithCredential(
            userName,
            phoneNumber,
            verifyCode,
            smsCode,
            userPassword,
            context,
          )
          .then((value) {
        if (_auth.currentUser != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false, // Supprime toutes les autres routes
          );
        }
      });
    } catch (e) {
      const SnackBar(
        content: Text('Erreur de vérification: '),
        backgroundColor: Colors.red,
      );
    }
  }

  void sendSMS(
    BuildContext context,
    String phoneNumber,
    String userName,
    String userPassword,
  ) async {
    // String phoneNumber = phoneNumberController.text;

    // Initialize Firebase Auth
    FirebaseAuth auth = FirebaseAuth.instance;

    print('sendToPhoneCode💕💕💕💕💕');
    print(phoneNumber);
    print(userName);
    print(userPassword);

    // Verify the phone number
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieve OTP and sign in
        auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('le code est envoyé à $phoneNumber'),
            backgroundColor: Colors.red,
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('erreur lors de l\'envoi du code '),
            backgroundColor: Colors.red,
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterCodePage(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
              userName: userName,
              userPassword: userPassword,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('SMS sent to $phoneNumber'),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

// auth with email and password
  Future loginUserWithEmailAndPassword(email, password, context) async {
    await _read
        .read(authServiceProvider)
        .signInWithEmailAndPassword(email, password, context);
  }

  Future<ConnectivityResult> checkNetworkConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
    return _connectivityResult;
  }
}
