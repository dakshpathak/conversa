import 'dart:developer';

import 'package:conversa/HomeScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/authentication/mail_verification.dart';
import 'package:conversa/authentication/user_model.dart';
import 'package:conversa/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  final userRepo = Get.put(UserRepository());

  //functions which we will call from the UI design

  Future registerUser(String email, String password)async {
   await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password).whenComplete(()async{
         await AuthenticationRepository.instance.EmailVerification().then((value){
           Get.to(() => Mailverification());
         });
   });

    // if (error != null) {
    //   Get.showSnackbar(GetSnackBar(
    //     message: error.toString(),
    //   ));
    // }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);

  }
}
