import 'package:conversa/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Signupcomplete extends StatefulWidget {
  const Signupcomplete({Key? key}) : super(key: key);

  @override
  State<Signupcomplete> createState() => _SignupcompleteState();
}

class _SignupcompleteState extends State<Signupcomplete> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        Duration(seconds: 3),
        () {
          Get.offAll(() => Homescreen());
        },
        // () => Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => Homescreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_2vafrx9q.json',
            animate: true,
          ),
          Text(
            "Account Created Successfully!",
            style: GoogleFonts.poppins(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ]),
      ),
    );
  }
}
