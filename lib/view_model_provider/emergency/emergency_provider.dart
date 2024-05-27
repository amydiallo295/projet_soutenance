import 'package:emergency/models/model_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class EmergencyNotifier extends Notifier<Set<EmergencySubmission>> {
  @override
  Set<EmergencySubmission> build() {
    return {};
  }
  //methode to read emergency submissions
}

final emergencyProvider = NotifierProvider<EmergencyNotifier, Set<EmergencySubmission>>(
    () => EmergencyNotifier());
