import 'package:conversa/HomeScreen.dart';
import 'package:conversa/SignUpScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _emailformkey = GlobalKey<FormState>();
  final _passwordformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 200,
            elevation: 0,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/loginbg.png'),
                        fit: BoxFit.fill)),
                child: Center(
                    child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 40),
                )),
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
            hasScrollBody: false,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: _emailformkey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                          controller: controller.email,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Email",
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 15, color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.email),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: _passwordformkey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          controller: controller.password,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 15, color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: size.width / 1.2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailformkey.currentState!.validate() ||
                            _passwordformkey.currentState!.validate()) {
                          SignInController.instance.loginUser(
                              controller.email.text.trim(),
                              controller.password.text.trim());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Enter correct credentials",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )));
                        }
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: Color.fromRGBO(203, 207, 236, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45)),
                        shadowColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Don't have an account?",
                    style:
                        GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Signup()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*
* Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // height: size.height / 14,
                      width: size.width / 1.2,
                      child: TextFormField(
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter credential";
                          }
                          return null;
                        },
                        controller: _email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: "Email",
                          labelStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      // height: size.height / 14,
                      width: size.width / 1.2,
                      child: TextFormField(
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter credential";
                          }
                          return null;
                        },
                        controller: _password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: "Password",
                          labelStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width / 1.2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Homescreen()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Logging you in!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Enter correct credentials",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )));
                          }
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Color.fromRGBO(203, 207, 236, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)),
                          shadowColor: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => Signup()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              )
* */
