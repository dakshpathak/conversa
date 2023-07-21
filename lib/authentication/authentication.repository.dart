import 'dart:developer';

import 'package:conversa/HomeScreen.dart';
import 'package:conversa/LoginScreen.dart';
import 'package:conversa/authentication/mail_verification.dart';
import 'package:conversa/exception/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;

  //for signup
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
     User? user =  (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)).user;

     if (user==null){
       print("Account is not created");
     }
     else{
       log("CREATE ACCOUNT STATUS: ${_auth.currentUser!.uid}");
       print ("Account created");
     }
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  //for signin
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

      if (user == null){
        print("Login Failed");
      }
      else{
        print("login Sucessfull");
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  //for logout
  Future<void> logout() async => await _auth.signOut();


  //for email verification
  Future<bool> EmailVerification() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser!=null){
        await currentUser.sendEmailVerification().whenComplete((){
          log("mail sent");
          return true;
        });
        log(currentUser.toString());
      }else{
        log("user not found");
      }
      // await _auth.currentUser.sendEmailVerification();
    }on FirebaseException catch (e) {
      log(e.message.toString());
    }
    return false;
  }
}
