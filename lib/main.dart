import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_using_flutter/common/colors.dart';
import 'package:whatsapp_clone_using_flutter/features/welcome/screens/welcome_screen.dart';
import 'package:whatsapp_clone_using_flutter/firebase_options.dart';
import 'package:whatsapp_clone_using_flutter/router.dart';
import 'package:whatsapp_clone_using_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        )
      ),
      home: const WelcomeScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
