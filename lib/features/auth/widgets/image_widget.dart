import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final File? image;
  final String? photoUrl;
  const ProfileImageWidget({Key? key, this.image, this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl= "https://cdn-icons-png.flaticon.com/128/149/149071.png";
    if(photoUrl!=null){
      imageUrl= photoUrl!;
    }
    return image == null
        ? CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          )
        : CircleAvatar(
            radius: 50,
            backgroundImage: FileImage(image!),
          );
  }
}
