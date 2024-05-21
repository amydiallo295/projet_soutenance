




import 'package:emergency/ui/sreens/InformationPage.dart';
import 'package:emergency/ui/sreens/emergencyallPage.dart';
import 'package:emergency/ui/sreens/helpage.dart';
import 'package:emergency/ui/sreens/reportPage.dart';
import 'package:flutter/material.dart';

Route createRouteSumited () {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const EmergencySubmissionPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
  
  
Route createRouteAbout () {
  print('jdkjdkjjkdjkd');
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



  Route createRouteCall () {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const EmergencyCallPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }


   Route createRouteAdvice () {
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