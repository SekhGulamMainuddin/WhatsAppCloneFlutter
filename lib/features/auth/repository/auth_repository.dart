import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_clone_using_flutter/common/firebase_dependecy_provider.dart';
import 'package:whatsapp_clone_using_flutter/common/repository/common_repository.dart';
import 'package:whatsapp_clone_using_flutter/common/upload_enum.dart';
import 'package:whatsapp_clone_using_flutter/models/user_model.dart';

final authRepositoryProvider = Provider((ref) =>
    AuthRepository(ref.watch(firebaseAuth), ref.watch(firebaseFirestore), ref));

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  AuthRepository(this._auth, this._firestore, this._ref);

  void sendOTPToPhone(String phoneNumber, void otpCodeSent(String, Int)) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credentials) {},
        verificationFailed: (e) {},
        codeSent: (String verificationId, int? resendToken) {
          otpCodeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint("this is the error $e");
      Fluttertoast.showToast(msg: "Some error occurred while send the OTP");
    }
  }

  void verifyOTP(String otp, String verificationId,
      void Function(bool success) verifySuccess) async {
    try {
      final credentials = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await _auth.signInWithCredential(credentials);
      verifySuccess(true);
    } catch (e) {
      verifySuccess(false);
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: "Some error occurred while verifying the OTP");
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final userData = await _firestore
          .collection("users")
          .doc(_auth.currentUser?.uid)
          .get();
      if (userData.exists && userData.data() != null) {
        return UserModel.fromMap(userData.data()!);
      }
    } catch (e) {
      return null;
    }
  }

  Future<UploadStatus> updateUserNameAndPhoto(
      File? image, String photoUrl, String userName) async {
    try {
      if (image != null) {
        String? imageUrl = await _ref
            .read(commonRepositoryProvider)
            .uploadFile(image, "profilePic/${_auth.currentUser?.uid}");
        if (imageUrl != null) {
          photoUrl = imageUrl;
        }
      }
      final userModel = UserModel(
        userName: userName,
        phoneNumber: _auth.currentUser!.phoneNumber!,
        uid: _auth.currentUser!.uid,
        isOnline: true,
        photoUrl: photoUrl,
        groupId: []
      );
      await _firestore.collection("user").doc(_auth.currentUser!.uid).set(userModel.toMap());
      return UploadStatus.success;
    } catch (e) {
      debugPrint(e.toString());
    }
    return UploadStatus.failure;
  }
}
