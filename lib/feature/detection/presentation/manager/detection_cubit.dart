import 'package:bloc/bloc.dart';
import 'package:final_proj/feature/detection/data_source/repo/repo_impl.dart';
import 'package:meta/meta.dart';

import '../../data_source/data/data_remote.dart';
import '../../data_source/model/detection_model.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit() : super(DetectionInitial());
  DetectionRepoImpl detectionRepoImpl =
      DetectionRepoImpl(detectionRemote: DetectionRemote());

  Future<void> postDetection(DetectionModel data) async {
    emit(DetectionLoading());
    final result = await detectionRepoImpl.postDetection(data);
    result.fold(
      (failure) => emit(DetectionError(failure.message)),
      (detectionModel) => emit(DetectionSuccess(detectionModel)),
    );
  }
}
