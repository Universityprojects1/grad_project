import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_source/data/data_remote.dart';
import '../../../data_source/model/detection_model.dart';
import '../../../data_source/repo/repo_impl.dart';

part 'detection_camera_state.dart';

class DetectionCameraCubit extends Cubit<DetectionCameraState> {
  DetectionCameraCubit() : super(DetectionCameraInitial());
  DetectionRepoImpl detectionRepoImpl =
      DetectionRepoImpl(detectionRemote: DetectionRemote());

  Future<void> postDetection(DetectionModel data) async {
    emit(DetectionCameraLoading());
    final result = await detectionRepoImpl.postDetection(data);
    result.fold(
      (failure) => emit(DetectionCameraFailure(failure.message)),
      (detectionModel) => emit(DetectionCameraSuccess(detectionModel)),
    );
  }
}
