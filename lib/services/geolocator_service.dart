import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class GeolocatorService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Les services de localisation sont désactivés.");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Les permissions de localisation sont refusées.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Les permissions de localisation sont refusées de façon permanente, nous ne pouvons pas demander les permissions ");
    }
    final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint("currentPosition.toString(): ${currentPosition.toString()}");
    return currentPosition;
  }
}

final geolocatorServiceProvider =
    Provider<GeolocatorService>((ref) => GeolocatorService());
