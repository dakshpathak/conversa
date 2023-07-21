import 'package:conversa/authentication/user_model.dart';
import 'package:conversa/controllers/signup_controller.dart';
import 'package:conversa/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _emailformkey = GlobalKey<FormState>();
  final _nameformkey = GlobalKey<FormState>();
  final _passwordformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            elevation: 0,
            pinned: false,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('asset/loginbg.png').image,
                        fit: BoxFit.fill)),
                child: Center(
                  child: Text(
                    "SignUp",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 40),
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
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60))),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: _emailformkey,
                        child: TextFormField(
                          controller: controller.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "Enter Email",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40))),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: _nameformkey,
                        child: TextFormField(
                          controller: controller.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box),
                              labelText: "Enter name",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40))),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: _passwordformkey,
                        child: TextFormField(
                          controller: controller.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: "Enter password",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40))),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: size.width / 1.2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailformkey.currentState!.validate()) {
                          await SignUpController.instance
                              .registerUser(controller.email.text.trim(),
                                  controller.password.text.trim())
                              .whenComplete(() async {
                            final user = UserModel(
                                email: controller.email.text.trim(),
                                password: controller.password.text.trim(),
                                fullname: controller.name.text.trim(),
                                imageurl: '',
                                bio: '', uid: '');

                            await controller.createUser(user);
                          });
                        }
                      },
                      child: Text(
                        "Signup",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
