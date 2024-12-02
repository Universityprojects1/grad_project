// import 'dart:typed_data';
//
// import 'package:image_picker/image_picker.dart';
//
// class UploadImageService {
//   static  Uint8List? selectedImage;
//   static XFile? imageFile;
//
//
//   static pickImage(ImageSource imageSource) async {
//     final ImagePicker imagePicker = ImagePicker();
//     XFile? file = await imagePicker.pickImage(source: imageSource);
//     imageFile=file;
//     if (file != null) {
//       return await file.readAsBytes();
//     }
//     else{
//       selectedImage=null;
//     }
//   }
//
//   static selectImage(ImageSource imageSource) async {
//     Uint8List? image = await pickImage(imageSource);
//     image!=null?
//     selectedImage = image:null;
//
//   }
// }
