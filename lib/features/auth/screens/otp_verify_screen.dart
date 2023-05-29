import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_using_flutter/common/colors.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/user_detail_screen.dart';

class OTPVerifyScreen extends ConsumerWidget {

  final String verificationId;

  const OTPVerifyScreen({Key? key, required this.verificationId}) : super(key: key);

  static const routeName= "/opt-verify-screen";

  verifyOTP(BuildContext context, String otp, WidgetRef ref){
    ref.read(authControllerProvider).verifyOTP(verificationId, otp, (success) {
      if(success){
        Navigator.pushNamedAndRemoveUntil(context, UserDetail.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: whiteColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            const Text("OTP send please check your SMS"),
            const SizedBox(height: 20,),
            Container(
              width: size.width*0.5,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: tabColor
                  ),
                )
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "------",
                  hintStyle: TextStyle(
                    letterSpacing: 10,
                    fontSize: 18,
                    fontWeight: FontWeight.w900
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: tabColor, width: 2),
                  )
                ),
                style: const TextStyle(
                  letterSpacing: 10,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  if(value.length==6){
                    verifyOTP(context, value, ref);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
