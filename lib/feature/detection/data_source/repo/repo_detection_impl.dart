import 'package:either_dart/either.dart';
import 'package:final_proj/feature/detection/data_source/model/model_detection.dart';

import '../../../../core/erorr/failure.dart';
import '../data/detection_remote.dart';

class RepoDetectionImpl {
  final DetectionDataRemote detectionRemote;

  RepoDetectionImpl({required this.detectionRemote});

  Future<Either<Failure, Stream<ModelDetection>>> getDetection() async {
    return detectionRemote.stream();
  }
}
