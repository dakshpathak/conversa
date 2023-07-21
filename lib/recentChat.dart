import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversa/ChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentChat extends StatefulWidget {
  const RecentChat({Key? key}) : super(key: key);

  @override
  State<RecentChat> createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(45),
                    )),
              ),
            ),
          ),
          SliverFillRemaining(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(currentUid)
                      .collection("Messages")
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(snapshot.data.docs[index].id)
                                      .get(),
                                  builder: (context, friendSnapshot) {
                                    if (friendSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      if (friendSnapshot.hasData) {
                                        return ListTile(
                                          onTap: () {
                                            Get.to(() => Chatpage(
                                                  friendid: snapshot
                                                      .data.docs[index].id,
                                                  friendName: friendSnapshot
                                                      .data!
                                                      .get('name'),
                                                  friendImage: friendSnapshot
                                                      .data!
                                                      .get('Image'),
                                                ));
                                          },
                                          title: Text(
                                            friendSnapshot.data!.get('name'),
                                            style: GoogleFonts.poppins(),
                                          ),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fill,
                                              imageUrl: friendSnapshot.data!
                                                  .get('Image'),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data.docs[index]
                                                ['lastMessage'],
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(),
                                          ),
                                        );
                                      } else {
                                        return Text("no user found");
                                      }
                                    }
                                  });
                            });
                      } else {
                        return Center(
                          child: Text(
                            "Haven't done chat with anyone?",
                            style: GoogleFonts.poppins(),
                          ),
                        );
                      }
                    }
                    return CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }
}
