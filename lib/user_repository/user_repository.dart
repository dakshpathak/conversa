import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/authentication/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomeScreen.dart';
import '../authentication/mail_verification.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  createUser(UserModel user) async {
    String uid = auth.currentUser!.uid;
    log("CREATE USER STATUS: $uid");

    try {
      await _db
          .collection("Users")
          .doc(uid)
          .set(user.toJson())
          .whenComplete(
            () => Get.snackbar("Success", "Your account has been created",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                colorText: Colors.black),
          )
          .catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        print(error.toString());
      });
    } on FirebaseException catch (e) {
      log("CREATE USER STATUS: ${e.message.toString()}");
    }
  }
}
