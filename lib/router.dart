import 'package:flutter/material.dart';
import 'package:whatsapp_clone_using_flutter/common/widgets/widget_error.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/user_detail_screen.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/user_detail_screen.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone_using_flutter/features/auth/screens/otp_verify_screen.dart';
import 'package:whatsapp_clone_using_flutter/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OTPVerifyScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) =>
              OTPVerifyScreen(verificationId: verificationId));
    case UserDetail.routeName:
      return MaterialPageRoute(builder: (context) => const UserDetail());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: WidgetError(),
        ),
      );
  }
}
