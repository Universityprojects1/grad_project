import 'dart:io';


import 'package:dio/dio.dart';

class DetectionModel {
  final String? image;
  final File? imageFile;

  DetectionModel({this.image, this.imageFile});

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      image: json['image_with_label'] as String?,
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
