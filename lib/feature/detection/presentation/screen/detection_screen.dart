import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:final_proj/config/routes/routes.dart';
import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:final_proj/feature/detection/presentation/manager/detection_stream/detection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/image_picker.dart';
import '../../data_source/model/detection_model.dart';
import '../manager/detection_with_camera/detection_camera_cubit.dart';

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
    return BlocListener<DetectionCameraCubit, DetectionCameraState>(
      listener: (context, state) {
        if (state is DetectionCameraSuccess) {
          GoRouter.of(context)
              .push(AppRoute.detectionWithCamera, extra: state.detectionModel);
        }
        if (state is DetectionCameraFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is DetectionCameraLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Loading...")),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<DetectionCubit, DetectionState>(
          builder: (context, state) {
            if (state is DetectionStreamSuccess) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: FadeInUp(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            state.detectionModel.image ?? "",
                            width: double.infinity,
                            height: 300,
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
                                  state.detectionModel.label ?? "none",
                                  style:
                                      AppFonts.textSemiBold16(context).copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () async {
                          await _selectImage().then(
                            (value) {
                              if (_selectedImage != null) {
                                context
                                    .read<DetectionCameraCubit>()
                                    .postDetection(
                                      DetectionModel(
                                          imageFile: _selectedImage!),
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
              );
            } else if (state is DetectionStreamError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is DetectionStreamLoading) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.fourRotatingDots(
                        color: AppColor.primaryColor,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox(
              child: Center(
                child: Text(
                  "No detection data available",
                  style: AppFonts.textSemiBold16(context).copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
