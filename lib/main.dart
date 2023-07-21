
import 'package:conversa/ChatScreen.dart';
import 'package:conversa/HomeScreen.dart';
import 'package:conversa/LoginScreen.dart';
import 'package:conversa/SignUpScreen.dart';
import 'package:conversa/SignupcompleteScreen.dart';
import 'package:conversa/StartScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/authentication/mail_verification.dart';
import 'package:conversa/uploadimagebio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



