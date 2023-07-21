import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/ChatScreen.dart';
import 'package:conversa/authentication/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Connectuser extends StatefulWidget {
  const Connectuser({Key? key}) : super(key: key);

  @override
  State<Connectuser> createState() => _ConnectuserState();
}

class _ConnectuserState extends State<Connectuser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentuid = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> user;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').where("uid", isNotEqualTo: currentuid ).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    enabled: true,
                    onTap: () {
                      Get.to(() => Chatpage(
                          friendid: user['uid'],
                          friendName: user['name'],
                          friendImage: user['Image']));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(user["Image"]),
                    ),
                    trailing: Icon(Icons.add),
                    title: Text(
                      user["name"],
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    subtitle: Text(
                      user["Bio"],
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error fetching users");
          }
          return CircularProgressIndicator();
        },
      ),

      // body: CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(childCount: items.length,
      //               (BuildContext context, int index) {
      //             return Column(
      //               children: [
      //                 Container(
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(10.0),
      //                     child: ListTile(
      //                       onTap: () {},
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(10)),
      //                       leading: CircleAvatar(
      //                         backgroundColor: Colors.greenAccent,
      //                         child: Text(
      //                           items[index],
      //                           style: GoogleFonts.poppins(color: Colors.black),
      //                         ),
      //                       ),
      //                       title: Text("Item ${items[index]}"),
      //                     ),
      //                   ),
      //                 ),
      //                 Divider(
      //                   height: 1.5,
      //                   color: Colors.black,
      //                 ),
      //               ],
      //             );
      //           }),
      //     )
      //   ],
      // ),
    );
  }
}
