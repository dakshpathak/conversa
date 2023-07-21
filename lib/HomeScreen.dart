import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/Connectnew.dart';
import 'package:conversa/LoginScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/recentChat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController _search = TextEditingController();
  String profile = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    getProfilepic();
  }

  getProfilepic() async {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    if (firebaseuser != null) {
      await db.collection('Users').doc(firebaseuser.uid).get().then((value) {
        if (value!.exists) {
          final userData = value.data();
          profile = userData!['Image'];
          name = userData!['name'];
          log("Imageurl : $profile");
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              backgroundColor: Colors.greenAccent,
              pinned: true,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      AuthenticationRepository.instance.logout().whenComplete(() {
                        Get.offAll(() => LoginScreen());
                      });
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 35,
                    ))
              ],
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  size: 35,
                ),
              ),
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                log("ImageUrlinserted: $profile");
                return CachedNetworkImage(
                  imageUrl: profile,
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
                        "Hello $name!",
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
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
                      color: Colors.white
                    ),
                    child: TabBar(
                      labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      dividerColor: Colors.black,
                      enableFeedback: true,
                      indicatorPadding: EdgeInsets.only(left: 9, right: 9),
                      tabs: [
                        Tab(child: Text("Recent chats", style: GoogleFonts.poppins(color: Colors.black),),),
                        Tab(child: Text("Connect new", style: GoogleFonts.poppins(color: Colors.black),),),
                      ],
                    ),
                  ),
                )
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  RecentChat(),
                  Connectuser(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
