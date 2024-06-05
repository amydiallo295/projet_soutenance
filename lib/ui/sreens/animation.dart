// import 'package:emergency/ui/sreens/loginPage.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );

//     _controller.forward();
//     Timer(const Duration(seconds: 1), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const PhoneAuthPage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Center(
//         child: ScaleTransition(
//           scale: _animation,
//           child: Text("Emergency"),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

// import 'package:emergency/main.dart';
// import 'package:emergency/ui/screens/auth_page/login_page.dart';
// import 'package:emergency/ui/sreens/home_page/splashScreen/splashScreen.dart';
// import 'package:emergency/ui/sreens/loginPage.dart';
// import 'package:emergency/ui/sreens/verificationode.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     ref.watch(splashscreenModel).loadCurrentUser();
//     _navigateToHome();
//   }

//   _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 3), () {});
//     if (ref.watch(splashscreenModel).currentUser != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               // const HomeScreen()
//               Scaffold(
//             body: Container(),
//           ),
//         ),
//       );
//     }
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()
//           //  LoginPage()
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.redAccent, Colors.red],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(
//                 Icons.warning_amber_rounded,
//                 size: 80.0,
//                 color: Colors.white,
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 "Signalement d'urgence",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:emergency/main.dart';
import 'package:emergency/ui/screens/auth_page/login_page.dart';
import 'package:emergency/ui/sreens/home_page/profil.dart';
import 'package:emergency/ui/sreens/home_page/splashScreen/splashScreen.dart';
import 'package:emergency/ui/sreens/loginPage.dart';
import 'package:emergency/ui/sreens/verificationode.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Ne rien mettre ici qui dépend de ref
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(splashscreenModel).loadCurrentUser();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (ref.watch(splashscreenModel).currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning_amber_rounded,
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 20.0),
              Text(
                "Signalement d'urgence",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
