import 'package:emergency/utils/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// final GoRouter router =
//     GoRouter(initialLocation: StartAppView.routePath, routes: [
//   GoRoute(
//     path: '',
//     builder: (context, state) {
//       return Container();
//     },
//   )
// ]);

class StartAppView extends StatelessWidget {
  const StartAppView({super.key});
  static const startupRoute = 'startupView';

  @override
  Widget build(BuildContext context) {
    // Duration(seconds: 3)
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}
