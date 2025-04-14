import 'dart:io';

import 'package:final_proj/feature/detection/data/data_source/detection_remote_data_source.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

class DetectionRemoteDataImpl implements DetectionRemoteDataSource {



Future<File> loadYoloModel() async {
  final model = await FirebaseModelDownloader.instance.getModel(
    'potato',
    FirebaseModelDownloadType.localModelUpdateInBackground,
  );
  return model.file;
}

}