import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  try {
    final image= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image!=null && image.path.isNotEmpty){
      return File(image.path);
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Some Error Occurred while selecting images");
  }
  return null;
}
