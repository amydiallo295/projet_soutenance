import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _image = ImagePicker();
  Future<File?> pickImageFromGallery() async {
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
