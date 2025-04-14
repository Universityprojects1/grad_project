import 'dart:io';

import 'package:final_proj/feature/detection/data/model/result_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class DetectionRepo {
  Future<List<DetectionResult>> detect(XFile image);
}