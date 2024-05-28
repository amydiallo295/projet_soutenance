import 'dart:io';

import 'package:emergency/services/emergency_service.dart';
import 'package:emergency/services/geolocator_service.dart';
import 'package:emergency/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../models/model_report.dart';

// Provider pour gérer l'état de l'image sélectionnée
final selectedImageProvider =
    StateNotifierProvider<SelectedImageNotifier, File?>(
        (ref) => SelectedImageNotifier(ref));

// Provider pour gérer l'état de la position actuelle
final currentPositionProvider =
    StateNotifierProvider<CurrentPositionNotifier, Position?>(
        (ref) => CurrentPositionNotifier(ref));

// Provider pour gérer les champs du formulaire
final emergencyFormProvider =
    StateNotifierProvider<EmergencyFormNotifier, EmergencyFormState>(
        (ref) => EmergencyFormNotifier());

// Provider principal pour gérer la soumission d'urgence
final emergencyProvider =
    StateNotifierProvider<EmergencyNotifier, EmergencyState>((ref) {
  final emergencyService = ref.read(emergencyServiceProvider);
  final imagePickerService = ref.read(imagePickerServiceProvider);
  final geolocatorService = ref.read(geolocatorServiceProvider);
  final selectedImage = ref.read(selectedImageProvider.notifier);
  final currentPosition = ref.read(currentPositionProvider.notifier);
  final formState = ref.read(emergencyFormProvider.notifier);

  return EmergencyNotifier(
    emergencyService: emergencyService,
    imagePickerService: imagePickerService,
    geolocatorService: geolocatorService,
    selectedImage: selectedImage,
    currentPosition: currentPosition,
    formState: formState,
  );
});

// Modèle pour représenter l'état du formulaire
class EmergencyFormState {
  final String name;
  final String phone;
  final String description;
  final String location;
  final String? selectedEmergencyType;

  EmergencyFormState({
    required this.name,
    required this.phone,
    required this.description,
    required this.location,
    this.selectedEmergencyType,
  });

  EmergencyFormState copyWith({
    String? name,
    String? phone,
    String? description,
    String? location,
    String? selectedEmergencyType,
  }) {
    return EmergencyFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      location: location ?? this.location,
      selectedEmergencyType:
          selectedEmergencyType ?? this.selectedEmergencyType,
    );
  }
}

// Notifier pour gérer l'état du formulaire
class EmergencyFormNotifier extends StateNotifier<EmergencyFormState> {
  EmergencyFormNotifier()
      : super(EmergencyFormState(
          name: "",
          phone: "",
          description: "",
          location: "",
        ));

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  void updateEmergencyType(String? emergencyType) {
    state = state.copyWith(selectedEmergencyType: emergencyType);
  }

  void resetFields() {
    state = EmergencyFormState(
      name: "",
      phone: "",
      description: "",
      location: "",
    );
  }
}

// Notifier pour gérer l'état de l'image sélectionnée
class SelectedImageNotifier extends StateNotifier<File?> {
  final Ref _ref;

  SelectedImageNotifier(this._ref) : super(null);

  Future<void> getImageFromGallery() async {
    final imagePickerService = _ref.read(imagePickerServiceProvider);
    final pickedFile = await imagePickerService.pickImageFromGallery();

    if (pickedFile != null) {
      state = pickedFile;
    } else {
      debugPrint("No image selected");
    }
  }

  void resetImage() {
    state = null;
  }
}

// Notifier pour gérer l'état de la position actuelle
class CurrentPositionNotifier extends StateNotifier<Position?> {
  final Ref _ref;

  CurrentPositionNotifier(this._ref) : super(null);

  Future<void> getCurrentLocation() async {
    final geolocatorService = _ref.read(geolocatorServiceProvider);
    final position = await geolocatorService.getCurrentPosition();
    state = position;
  }

  void resetPosition() {
    state = null;
  }
}

// Modèle pour représenter l'état de la soumission d'urgence
class EmergencyState {
  final EmergencyFormState formState;
  final File? selectedImage;
  final Position? currentPosition;

  EmergencyState({
    required this.formState,
    required this.selectedImage,
    required this.currentPosition,
  });
}

// Notifier principal pour gérer la soumission d'urgence
class EmergencyNotifier extends StateNotifier<EmergencyState> {
  final EmergencyService emergencyService;
  final ImagePickerService imagePickerService;
  final GeolocatorService geolocatorService;
  final SelectedImageNotifier selectedImage;
  final CurrentPositionNotifier currentPosition;
  final EmergencyFormNotifier formState;

  EmergencyNotifier({
    required this.emergencyService,
    required this.imagePickerService,
    required this.geolocatorService,
    required this.selectedImage,
    required this.currentPosition,
    required this.formState,
  }) : super(EmergencyState(
          formState: formState.state,
          selectedImage: selectedImage.state,
          currentPosition: currentPosition.state,
        ));

  Future<void> submitEmergency() async {
    final newSubmission = EmergencySubmission(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      name: state.formState.name,
      phone: state.formState.phone,
      emergencyType: state.formState.selectedEmergencyType ?? '',
      description: state.formState.description,
      location: state.currentPosition != null
          ? '${state.currentPosition!.latitude}, ${state.currentPosition!.longitude}'
          : '',
    );

    if (state.selectedImage != null) {
      await emergencyService.submitEmergency(
          newSubmission, state.selectedImage!);
    }
  }
}
