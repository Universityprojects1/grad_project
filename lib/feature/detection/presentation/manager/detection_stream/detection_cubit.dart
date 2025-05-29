import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:final_proj/feature/detection/data_source/data/detection_remote.dart';
import 'package:final_proj/feature/detection/data_source/model/model_detection.dart';
import 'package:final_proj/feature/detection/data_source/repo/repo_detection_impl.dart';
import 'package:meta/meta.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit() : super(DetectionInitial());

  RepoDetectionImpl repoDetectionImpl =
      RepoDetectionImpl(detectionRemote: DetectionDataRemote());

  void startListening() {
    emit(DetectionStreamLoading());
    final result = repoDetectionImpl.getDetection();
    result.fold(
      (failure) => emit(DetectionStreamError(failure.message)),
      (stream) {
        stream.listen((modelDetection) {
          emit(DetectionStreamSuccess(ModelDetection(
            label: modelDetection.label,
            image: modelDetection.image,
          )));
        });
      },
    );
  }
}
