import 'dart:convert';
import 'dart:io';

import 'package:final_proj/core/utils/fonts.dart';
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
    await _imagePickerHelper.showImageSourceActionSheet(
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/Depth 4, Frame 0.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plant Detection",
                      style: AppFonts.textBold20(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Select an image to detect plant diseases",
                      style: AppFonts.textSemiBold16(context).copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<DetectionCubit, DetectionState>(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  await _selectImage().then(
                    (value) {
                      if (_selectedImage != null) {
                        context.read<DetectionCubit>().postDetection(
                              DetectionModel(imageFile: _selectedImage!),
                            );
                      }
                    },
                  );
                },
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
