import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:final_proj/core/erorr/failure.dart';

import '../model/model_detection.dart';

class DetectionDataRemote {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'detections';

  Either<Failure, Stream<ModelDetection>> stream() {
    try {
      return Right(_firestore
          .collection(_collectionName)
          .doc(_collectionName)
          .snapshots()
          .map((doc) {
        return ModelDetection.fromJson(doc.data() as Map<String, dynamic>);
      }));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
