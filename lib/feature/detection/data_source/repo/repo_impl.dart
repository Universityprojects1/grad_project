import 'package:either_dart/either.dart';
import 'package:final_proj/feature/detection/data_source/data/data_remote.dart';

import '../../../../core/erorr/failure.dart';
import '../model/detection_model.dart';

class DetectionRepoImpl {
  DetectionRemote detectionRemote;

  DetectionRepoImpl({required this.detectionRemote});

  Future<Either<Failure, DetectionModel>> postDetection(
      DetectionModel data) async {
    return await detectionRemote.postDetection(data);
  }
}
