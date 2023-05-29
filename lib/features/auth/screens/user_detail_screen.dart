import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_clone_using_flutter/common/colors.dart';
import 'package:whatsapp_clone_using_flutter/common/upload_enum.dart';
import 'package:whatsapp_clone_using_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_using_flutter/common/widgets/custom_button.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/widgets/image_widget.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_using_flutter/models/user_model.dart';
import 'package:whatsapp_clone_using_flutter/screens/home_screen.dart';

class UserDetail extends ConsumerStatefulWidget {
  static const routeName = "/user-detail-screen";

  const UserDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends ConsumerState<UserDetail> {
  final nameController = TextEditingController();
  UserModel? _userModel;
  File? _image;
  UploadStatus uploadStatus = UploadStatus.success;

  void pickImage() async {
    _image = await pickImageFromGallery();
    setState(() {});
  }

  void updateDetails() async {
    uploadStatus = UploadStatus.uploading;
    setState(() {});
    uploadStatus =
        await ref.read(authControllerProvider).updateUserNameAndPhoto(
              _image,
              _userModel == null
                  ? "https://cdn-icons-png.flaticon.com/128/149/149071.png"
                  : _userModel!.photoUrl,
              nameController.text,
            );
    if (uploadStatus == UploadStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    } else {
      setState(() {
        Fluttertoast.showToast(msg: "Failed to Update Details");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    _image == null
                        ? ref.read(userDataProvider).when(data: (data) {
                            _userModel = data;
                            return ProfileImageWidget(
                              image: null,
                              photoUrl: data?.photoUrl,
                            );
                          }, error: (e, t) {
                            return ProfileImageWidget(
                                image: _image, photoUrl: null);
                          }, loading: () {
                            return ProfileImageWidget(
                              image: _image,
                              photoUrl: null,
                            );
                          })
                        : ProfileImageWidget(
                            image: _image,
                            photoUrl: "",
                          ),
                    Positioned(
                      top: 60,
                      left: 60,
                      child: IconButton(
                        onPressed: pickImage,
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12,
                          child: Icon(
                            Icons.add_circle_outlined,
                            color: tabColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  enableSuggestions: true,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: tabColor,
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 80,
                  child: CustomButton(
                    text: "NEXT",
                    onPressed: updateDetails,
                  ),
                ),
              ],
            ),
            if (uploadStatus == UploadStatus.uploading)
              const Center(
                child: CircularProgressIndicator(
                  color: tabColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
