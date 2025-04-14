import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:final_proj/feature/detection/data/model/result_model.dart';
import 'package:final_proj/feature/detection/data/repo/detection_repo.dart';

class DetectionRepoImpl implements DetectionRepo {
  @override
  Future<List<DetectionResult>> detect(XFile image) async {
    try {
      var modelFile = await loadYoloModel();
      print("Model loaded successfully: ${modelFile.path}");

      // 1. Preprocess the image
      final inputTensor = await preprocessImage(image);
      print("Image preprocessed, tensor size: ${inputTensor.length}");

      // 2. Load and run the model
      final interpreter = await tfl.Interpreter.fromFile(modelFile);
      print("Interpreter created successfully");

      // Set model input and output shapes based on your model info
      final inputBuffer = inputTensor.reshape([1, 640, 640, 3]);
      print("Input buffer reshaped");

      // Prepare output tensor - shape [1, 7, 8400]
      final outputShape = [1, 7, 8400];
      final output = List.generate(
        outputShape[0],
        (_) => List.generate(
          outputShape[1],
          (_) => List<double>.filled(outputShape[2], 0.0),
        ),
      );
      print("Output buffer created");

      // Run inference
      print("Running inference...");
      interpreter.run(inputBuffer, output);
      print("Inference completed");

      // Close the interpreter to free resources
      interpreter.close();
      print("Interpreter closed");

      // 3. Post-process the results - we have 2 classes (based on your model)
      print("Starting post-processing");
      // Use a much lower threshold for debugging
      final results = postProcess(output, confThreshold: 0.0001);
      print("Post-processing completed, found ${results.length} detections");

      return results;
    } catch (e) {
      print("Error in detect method: $e");
      // Return empty list instead of throwing
      return [];
    }
  }

  Future<File> loadYoloModel() async {
    final model = await FirebaseModelDownloader.instance.getModel(
      'potato',
      FirebaseModelDownloadType.localModelUpdateInBackground,
    );
    return model.file;
  }

  // Updated to work with XFile instead of File
  Future<Float32List> preprocessImage(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = decodeImage(bytes);
    if (image == null) throw Exception('Cannot decode image');

    // Resize to model's input size
    final resized = copyResize(image, width: 640, height: 640);

    // Create a Float32List for the input tensor
    final input = Float32List(1 * 640 * 640 * 3);
    int index = 0;

    // YOLOv8 typically expects RGB input normalized to [0,1]
    for (int y = 0; y < 640; y++) {
      for (int x = 0; x < 640; x++) {
        final pixel = resized.getPixel(x, y);

        final mean = [0.485, 0.456, 0.406]; // ImageNet means
        final std = [0.229, 0.224, 0.225]; // ImageNet std devs

// Modified normalization
        final r = (pixel.r / 255.0 - mean[0]) / std[0];
        final g = (pixel.g / 255.0 - mean[1]) / std[1];
        final b = (pixel.b / 255.0 - mean[2]) / std[2];

        // Store in the input tensor (RGB order)
        input[index++] = r;
        input[index++] = g;
        input[index++] = b;
      }
    }

    return input;
  }

  List<DetectionResult> postProcess(List<List<List<double>>> output,
      {double confThreshold = 0.0001}) {
    // Use very low threshold for debugging
    final List<DetectionResult> results = [];

    try {
      final raw = output[0]; // shape [7][8400]

      // Add debug info
      print("Raw output shape: [${raw.length}][${raw[0].length}]");

      // Safety check for dimensions
      if (raw.length < 7) {
        print(
            "Warning: Output format doesn't match expected shape. Found ${raw.length} rows instead of 7");
        return [];
      }

      // Log highest confidence detection for debugging
      int highestConfIndex = 0;
      double highestConf = raw[4][0];
      for (int i = 1; i < raw[0].length; i++) {
        if (raw[4][i] > highestConf) {
          highestConf = raw[4][i];
          highestConfIndex = i;
        }
      }
      print("Highest confidence: $highestConf at index $highestConfIndex");

      for (int i = 0; i < raw[0].length; i++) {
        try {
          final x = raw[0][i];
          final y = raw[1][i];
          final w = raw[2][i];
          final h = raw[3][i];
          final conf = raw[4][i];

          if (conf < confThreshold) continue;

          // Get class index with max score
          final List<double> scores = [];
          for (int c = 5; c < raw.length; c++) {
            scores.add(raw[c][i]);
          }

          if (scores.isEmpty) continue;

          double maxScore = scores[0];
          int classIndex = 0;

          for (int j = 1; j < scores.length; j++) {
            if (scores[j] > maxScore) {
              maxScore = scores[j];
              classIndex = j;
            }
          }

          results.add(DetectionResult(x, y, w, h, conf, classIndex));
        } catch (e) {
          print("Error processing detection at index $i: $e");
        }
      }
    } catch (e) {
      print("Error in postProcess: $e");
    }

    return results;
  }
}
