import 'package:emergency/main.dart';
import 'package:emergency/ui/sreens/information_page.dart';
import 'package:emergency/ui/sreens/emergency_all_page.dart';
import 'package:emergency/ui/sreens/helpage.dart';
import 'package:emergency/ui/sreens/report_page.dart';
import 'package:flutter/material.dart';

Route createRouteSumited() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const EmergencySubmissionPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route createRouteAbout() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const InfoPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route createRouteCall() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const EmergencyCallPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route createRouteAdvice() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AdvicePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route createRouteHomeScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
