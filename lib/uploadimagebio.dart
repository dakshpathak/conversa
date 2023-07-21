import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/SignupcompleteScreen.dart';
import 'package:conversa/authentication/user_model.dart';
import 'package:conversa/controllers/profilePic_bio_controller.dart';
import 'package:conversa/controllers/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class uploadimagebio extends StatefulWidget {
  const uploadimagebio({Key? key}) : super(key: key);

  @override
  State<uploadimagebio> createState() => _uploadimagebioState();
}

class _uploadimagebioState extends State<uploadimagebio> {
  final controller = Get.put(ProfilepicbioController());

  // final TextEditingController _bio = TextEditingController();
  XFile? image;
  final ImagePicker picker = ImagePicker();
  var photo;

  Future getImage(ImageSource imageSource) async {
    var img = await picker.pickImage(source: imageSource);

    setState(() {
      image = img;
      controller.Image = image;
      photo = File(image!.path);
    });
  }



  void selectPicker() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(width: 1, color: Colors.black)),
      Container(
        height: 200,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                    Get.back();
                  },
                  icon: Image.asset(
                    'asset/camera.png',
                  ),
                  iconSize: 100,
                ),
                IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Get.back();
                    },
                    icon: Image.asset(
                      'asset/discussion.png',
                    ),
                    iconSize: 100),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Camera",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "Gallery",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 200,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('asset/uploadbgg.png'),
                          fit: BoxFit.fill)));
            }),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
              ),
            ),
          ),
          SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      onTap: selectPicker,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: photo != null
                            ? FileImage(
                                photo,
                              )
                            : Image.asset('asset/photographer.png',
                                    fit: BoxFit.fill)
                                .image,
                        backgroundColor: Colors.grey.shade100,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.add_a_photo,
                              weight: 200, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tap to add your profile photo",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(27.0),
                        child: TextField(
                          maxLines: 2,
                          keyboardType: TextInputType.multiline,
                          controller: controller.Bio,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 3),
                            hintText: "Enter Your Bio here!",
                            hintStyle: GoogleFonts.poppins(fontSize: 20),
                            labelText: "Bio",
                            labelStyle: GoogleFonts.poppins(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      height: 55,
                      child: OutlinedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () async {
                          await controller.uploadtoFirebasestorage();
                          Get.offAll(() => Signupcomplete());
                        },
                        child: Text(
                          "Complete setup",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
