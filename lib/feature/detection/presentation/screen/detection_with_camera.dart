import 'dart:convert';

import 'package:final_proj/feature/detection/data_source/model/detection_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/fonts.dart';

class DetectionWithCamera extends StatelessWidget {
  const DetectionWithCamera({super.key, required this.detectionModel});

  final DetectionModel detectionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.memory(
                base64Decode(detectionModel.image ?? ""),
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20,width: double.infinity,),
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
                    detectionModel.label ?? "none",
                    style: AppFonts.textSemiBold16(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
