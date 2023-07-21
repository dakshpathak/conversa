import 'dart:async';

import 'package:conversa/HomeScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/uploadimagebio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController{

  late Timer _timer;
  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }


  // send or resend email verification
  Future<void> sendVerificationEmail() async {

    try{
      await AuthenticationRepository.instance.EmailVerification();
    } catch (e){
      Get.snackbar("ERROR", e.toString());
    }
  }

  void setTimerForAutoRedirect(){
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified){
        timer.cancel();
        Get.offAll(() => uploadimagebio());
      }

    });
  }

  void manuallyCheckVerification(){
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified){
      Get.offAll(() => uploadimagebio());
    }
  }
}