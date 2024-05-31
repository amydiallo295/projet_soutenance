import 'package:flutter/foundation.dart';

@immutable
class ProfileState {
  final User? currentUser;

  const ProfileState({this.currentUser});

  ProfileState copyWith({
    User? currentUser,
  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class User {
  final String displayName;
  final String phoneNumber;

  User({
    required this.displayName,
    required this.phoneNumber,
  });

  User copyWith({
    String? displayName,
    String? phoneNumber,
  }) {
    return User(
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
