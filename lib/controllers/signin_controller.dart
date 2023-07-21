import 'package:conversa/HomeScreen.dart';
import 'package:conversa/LoginScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{

  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser (String email, String password){
    AuthenticationRepository.instance.loginWithEmailAndPassword(email, password).whenComplete(() {
      // Get.to(() => Homescreen());
      Get.offAll(()=>Homescreen());
    });
    // final auth = AuthenticationRepository.instance;
    // auth.setInitialScreen(auth.firebaseUser as User?);

  }
}