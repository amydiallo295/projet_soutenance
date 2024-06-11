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

  // send message to user and display login page

  Future<void> sendToPhoneCode(BuildContext context, String phoneNumber,
      String userName, String userPassword) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Vous pouvez gérer l'authentification automatique ici si nécessaire
        },
        verificationFailed: (FirebaseAuthException e) {
          // Gestion des erreurs de vérification
          String errorMessage;
          switch (e.code) {
            case 'invalid-phone-number':
              errorMessage = 'Le numéro de téléphone est invalide.';
              break;
            case 'too-many-requests':
              errorMessage =
                  'Trop de tentatives. Veuillez réessayer plus tard.';
              break;
            default:
              errorMessage = 'Erreur de vérification: ${e.message}';
              break;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
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
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Cette méthode est appelée lorsque le temps imparti pour récupérer automatiquement le code de vérification expire.
          const errorMessage =
              'Délai de récupération automatique du code expiré';

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      const errorMessage =
          'Erreur lors de la vérification du numéro de téléphone';

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
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
