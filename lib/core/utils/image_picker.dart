import 'dart:async';
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
  Future<void> showImageSourceActionSheet({
    required BuildContext context,
    required Function(File) onImagePicked,
  }) async {
    final Completer<File?> completer = Completer<File?>();

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
                  if (file != null) {
                    onImagePicked(file);
                    completer.complete(file);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final file = await pickImage(ImageSource.gallery);
                  if (file != null) {
                    onImagePicked(file);
                    completer.complete(file);
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    await completer.future;
  }
}