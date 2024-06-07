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

//  envoi de code a l'utilisateur
  // Future<void> sendToPhoneCode(BuildContext context, String phoneNumber,
  //     String userName, String userPassword) async {
  //   print('sendToPhoneCode💕💕💕💕💕');
  //   print(phoneNumber);
  //   print(userName);
  //   print(userPassword);
  //   try {
  // await _auth.verifyPhoneNumber(
  //   phoneNumber: phoneNumber,
  //   verificationCompleted: (PhoneAuthCredential credential) async {},
  //   verificationFailed: (FirebaseAuthException e) {
  //     if (e.code == 'invalid-phone-number') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Numéro de numéro invalide'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     } else if (e.code == 'too-many-requests') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Trop de requêtes'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //   },
  //   codeSent: (String verificationId, int? resendToken) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => EnterCodePage(
  //           verificationId: verificationId,
  //           phoneNumber: phoneNumber,
  //           userName: userName,
  //           userPassword: userPassword,
  //         ),
  //       ),
  //     );
  //   },
  //   codeAutoRetrievalTimeout: (String verificationId) {
  //     if (_auth.currentUser != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content:
  //               Text('Délai de récupération automatique du code expiré'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   },
  //   timeout: const Duration(seconds: 60),
  // );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content:
  //             Text('Erreur lors de la vérification du numéro de téléphone'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> sendToPhoneCode(
    BuildContext context,
    String phoneNumber,
    String userName,
    String userPassword,
  ) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    print('sendToPhoneCode💕💕💕💕💕');
    print(phoneNumber);
    print(userName);
    print(userPassword);

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This is called when verification is completed automatically.
        },
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage;
          if (e.code == 'invalid-phone-number') {
            errorMessage = 'Numéro de téléphone invalide';
          } else if (e.code == 'too-many-requests') {
            errorMessage = 'Trop de requêtes. Veuillez réessayer plus tard.';
          } else {
            errorMessage =
                'Échec de la vérification du téléphone : ${e.message}';
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Délai de récupération automatique du code expiré'),
              backgroundColor: Colors.red,
            ),
          );
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Erreur lors de la vérification du numéro de téléphone : ${e.toString()}'),
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
