// // ignore_for_file: use_build_context_synchronously

// import 'package:emergency/main.dart';
// import 'package:emergency/ui/screens/auth_page/login_page.dart';
// import 'package:emergency/ui/sreens/home_page/splashScreen/splashScreen.dart';
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
//     // Ne rien mettre ici qui dépend de ref

//     print("voir user init😁😁😁😁⛪⛪⛪⛪⛪");
//   }

//   @override
//   void didChangeDependencies() {
//     print("voir user init😁😁😁😁⛪⛪⛪⛪⛪444");
//     super.didChangeDependencies();
//     ref.watch(splashscreenModel).loadCurrentUser();
//     _navigateToHome();
//   }

//   _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 3), () {});
//     if (ref.watch(splashscreenModel).currentUser != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     }
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
//                 size: 100.0,
//                 color: Colors.white,
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 "Signalement d'urgence",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
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

// ignore_for_file: use_build_context_synchronously

import 'package:emergency/main.dart';
import 'package:emergency/ui/screens/auth_page/login_page.dart';
import 'package:emergency/ui/sreens/home_page/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();

    ref.read(splashscreenModel).loadCurrentUser();
    _navigateToHome();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (ref.read(splashscreenModel).currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()
            //
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe57373), Color(0xFFef5350)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    size: 100.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Signalement d'urgence",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 20.0),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
