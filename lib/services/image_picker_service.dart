import 'dart:io';

import 'package:emergency/utils/ui_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ImagePickerService {
  final _image = ImagePicker();
  Future<File?> pickImageFromGallery() async {
    logger.i("pickImageFromGallery");
    final pickedFile =
        await _image.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}

final imagePickerServiceProvider =
    Provider<ImagePickerService>((ref) => ImagePickerService());
