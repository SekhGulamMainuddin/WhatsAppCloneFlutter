import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_clone_using_flutter/common/colors.dart';
import 'package:whatsapp_clone_using_flutter/common/widgets/custom_button.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {

  static const routeName= "/welcome-screen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Welcome to WhatsApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 33, color: whiteColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              "assets/welcome_background_image.png",
              width: 315,
              height: 315,
            ),
            SizedBox(
              height: size.height / 9,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and Continue" to accept the terms',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
