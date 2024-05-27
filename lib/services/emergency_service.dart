import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/model_report.dart';

class EmergencyService {
  Future<void> submitEmergency(
      EmergencySubmission submission, File imageFile) async {
    debugPrint('Submitting emergency submission: $submission');
    debugPrint('Submitting emergency image: $imageFile');
  }
}
// Providers pour les services externes
final emergencyServiceProvider =
    Provider<EmergencyService>((ref) => EmergencyService());