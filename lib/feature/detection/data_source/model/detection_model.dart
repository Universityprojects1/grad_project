import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class DetectionModel {
  final String? image;
  final File? imageFile;

  DetectionModel({this.image, this.imageFile});

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      image: json['image_base64'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'image': imageFile != null
          ? MultipartFile.fromFileSync(imageFile!.path, filename: imageFile!.path.split('/').last)
          : null,
    };
  }
}
