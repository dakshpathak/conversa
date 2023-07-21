import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/SignupcompleteScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilepicbioController extends GetxController {
  static ProfilepicbioController get instance => Get.find();

  final Bio = TextEditingController();
  XFile? Image;
  String imageUrl = '';

  Future<void> uploadtoFirebasestorage() async {
    //creating a reference of the storage root

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('profilePhotos');

    //creating a reference for the images to be stored
    Reference referenceImageToUpload =
        referenceDirImages.child('${Image?.name}');

    try {
      //store the file now
      await referenceImageToUpload.putFile(File(Image!.path));

      //success: get the download url of image
      imageUrl = await referenceImageToUpload.getDownloadURL();

      //upload url to document
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid;
      final _db = FirebaseFirestore.instance;
      await _db
          .collection("Users")
          .doc(uid)
          .update({"Image": imageUrl, "Bio": Bio.text, "uid": uid});
    } catch (error) {
      //some error occurred
    }
  }
}
