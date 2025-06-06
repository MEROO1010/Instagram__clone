import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    return picked != null ? File(picked.path) : null;
  }

  static Future<File?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    return picked != null ? File(picked.path) : null;
  }
}
