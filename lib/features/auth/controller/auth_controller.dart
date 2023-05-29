import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_using_flutter/common/upload_enum.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone_using_flutter/models/user_model.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(ref.watch(authRepositoryProvider)),
);

final userDataProvider = FutureProvider(
  (ref) => ref.watch(authControllerProvider).getUserData(),
);

class AuthController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  void sendOTPToPhone(String phoneNumber, void otpCodeSent(String, Int)) {
    _authRepository.sendOTPToPhone(
      phoneNumber,
      (verificationID, resendToken) =>
          {otpCodeSent(verificationID, resendToken)},
    );
  }

  void verifyOTP(String verificationId, String otp,
      void Function(bool success) onSuccess) {
    _authRepository.verifyOTP(otp, verificationId, (success) {
      onSuccess(success);
    });
  }

  Future<UserModel?> getUserData() async {
    UserModel? userModel = await _authRepository.getUserData();
    return userModel;
  }

  Future<UploadStatus> updateUserNameAndPhoto(
      File? image, String photoUrl, String userName) async {
    return await _authRepository.updateUserNameAndPhoto(
      image,
      photoUrl,
      userName,
    );
  }
}
