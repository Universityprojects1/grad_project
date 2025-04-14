import 'package:bloc/bloc.dart';
import 'package:final_proj/core/services/upload_image_service.dart';
import 'package:final_proj/feature/detection/data/model/result_model.dart';
import 'package:final_proj/feature/detection/data/repo/detection_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'detection_state.dart';

class DetectionCubit extends Cubit<DetectionState> {
  DetectionCubit(this.detectionRepo) : super(DetectionInitial());
  DetectionRepo detectionRepo;
  XFile ? imageFile;
  void detect()async{
    await UploadImageService.pickImage(ImageSource.gallery);
    imageFile=UploadImageService.imageFile;
    if (imageFile != null) {
      emit(DetectionLoading());
      try {
        final results = await detectionRepo.detect(imageFile!);
        print( results.first.classIndex);
        emit(DetectionSuccess(results));
      } catch (e) {
        print("Error during detection: $e");
        emit(DetectionError(e.toString()));
      }
    } else {
      print( "No image selected");
      emit(DetectionError("No image selected"));
    }

  }
  
}
