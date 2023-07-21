import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/HomeScreen.dart';
import 'package:conversa/authentication/user_model.dart';
import 'package:conversa/chatBubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatpage extends StatefulWidget {
  final String friendid;
  final String friendName;
  final String friendImage;

  Chatpage({
    required this.friendid,
    required this.friendName,
    required this.friendImage,
  });

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _message = TextEditingController();

  GlobalKey<FormState> _messageKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    setState(() {
      pickedFile = result!.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentuid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.offAll(() => Homescreen());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              ),
            ),
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return CachedNetworkImage(
                imageUrl: widget.friendImage,
                fadeInDuration: Duration(seconds: 1),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                imageBuilder: (context, ImageProvider) => Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ImageProvider, fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100, left: 15),
                    child: Text(
                      widget.friendName,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
              );
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
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(currentuid)
                        .collection("Messages")
                        .doc(widget.friendid)
                        .collection('Chats')
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return Center(
                            child: Text(
                              "Say Hi!",
                              style: GoogleFonts.poppins(),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                currentuid;
                            return ChatBubble(
                                message: snapshot.data.docs[index]['message'],
                                isMe: isMe);
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )),
                Container(
                  child: Image.file(
                File(pickedFile!.path!),
                width: double.infinity,
                fit: BoxFit.cover,
                  ),
                ),
                Form(
                  key: _messageKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _message,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Enter your message",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              log("UID status : $currentuid");
                              String message = _message.text;

                              //for storing the data at sender's side
                              try {
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(currentuid)
                                    .collection("Messages")
                                    .doc(widget.friendid)
                                    .collection("Chats")
                                    .add({
                                  "senderId": currentuid,
                                  "receiverId": widget.friendid,
                                  "message": message,
                                  "date": DateTime.now(),
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(currentuid)
                                      .collection('Messages')
                                      .doc(widget.friendid)
                                      .set({
                                    "lastMessage": message,
                                  });
                                });
                              } on FirebaseException catch (e) {
                                print(e.message);
                              }

                              //for storing the data at receiver's side

                              try {
                                await FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(widget.friendid)
                                    .collection("Messages")
                                    .doc(currentuid)
                                    .collection("Chats")
                                    .add({
                                  "senderId": currentuid,
                                  "receiverId": widget.friendid,
                                  "message": message,
                                  "date": DateTime.now(),
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(widget.friendid)
                                      .collection('Messages')
                                      .doc(currentuid)
                                      .set({
                                    "lastMessage": message,
                                  });
                                });
                              } on FirebaseException catch (e) {
                                print(e.message);
                              }
                              _message.clear();
                            },
                            icon: Icon(Icons.send)),
                        prefixIcon: IconButton(
                            onPressed: () {
                             selectFile();
                            }, icon: Icon(Icons.add_a_photo)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45),
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
