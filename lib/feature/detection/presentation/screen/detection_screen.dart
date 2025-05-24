import 'dart:convert';
import 'dart:io';

import 'package:final_proj/feature/detection/presentation/manager/detection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/image_picker.dart';
import '../../data_source/model/detection_model.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File? _selectedImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  Future<void> _selectImage() async {
    _imagePickerHelper.showImageSourceActionSheet(
      context: context,
      onImagePicked: (File image) {
        _selectedImage = image;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<DetectionCubit, DetectionState>(
        builder: (context, state) {
          if (state is DetectionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetectionError) {
            return Center(
                child: Text(
              state.message,
              style: const TextStyle(color: Colors.white),
            ));
          } else if (state is DetectionSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(
                    base64Decode(state.detectionModel.image ?? ""),
                    height: 300,
                  ),
                  // You can add more widgets to display detection results here
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _selectImage().then(
            (value) {
              context
                  .read<DetectionCubit>()
                  .postDetection(DetectionModel(imageFile: _selectedImage!));
            },
          );
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
