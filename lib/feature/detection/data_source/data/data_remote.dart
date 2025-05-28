import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:final_proj/core/api/api_consumer.dart';
import 'package:final_proj/core/api/dio_consumer.dart';
import 'package:final_proj/core/api/endpoints.dart';
import 'package:final_proj/core/erorr/failure.dart';
import 'package:final_proj/feature/detection/data_source/model/detection_model.dart';

class DetectionRemote {
  ApiConsumer apiConsumer = DioConsumer(dio: Dio());

  Future<Either<Failure, DetectionModel>> postDetection(
      DetectionModel data) async {
    try {
      final response = await apiConsumer.post(EndPoints.detect,
          data: data.toJson(), isFromDara: true);
      return Right(DetectionModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
