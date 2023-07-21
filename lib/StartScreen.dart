import 'package:conversa/LoginScreen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black54,
        body: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    'asset/discussion.png',
                    height: size.height / 5,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Conversa",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: "Voga",
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Getting started', style: TextStyle(color: Colors.white, fontSize: 20),),
                ],
              ),
            ],
          ),
        ));
  }
}
