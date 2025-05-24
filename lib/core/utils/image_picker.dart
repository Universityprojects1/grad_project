import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    return null;
  }

  void showImageSourceActionSheet({
    required BuildContext context,
    required Function(File image) onImagePicked,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final file = await pickImage(ImageSource.camera);
                  if (file != null) onImagePicked(file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final file = await pickImage(ImageSource.gallery);
                  if (file != null) onImagePicked(file);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
