import 'package:conversa/LoginScreen.dart';
import 'package:conversa/authentication/authentication.repository.dart';
import 'package:conversa/controllers/mail_verification_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Mailverification extends StatelessWidget {
  const Mailverification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 180,
              elevation: 0,
              pinned: false,
              backgroundColor: Color.fromRGBO(240, 248, 255, 1),
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: Container(
                    height: 100,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('asset/email.png').image)),
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
                          topRight: Radius.circular(65),
                          topLeft: Radius.circular(65))),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Verify your email address",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 27),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "We've just send an email verification link on your email. Please check email and click on that link to verify it's you."
                        "\n\n If not redirected after verification, click on the Continue button.",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 340,
                        height: 55,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                          onPressed: () {
                            controller.manuallyCheckVerification();
                          },
                          child: Text(
                            "Continue",
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          controller.sendVerificationEmail();
                        },
                        focusColor: Colors.grey,
                        child: Text(
                          "Resend Email link",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: Text(
                          "<- Back to login",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                              fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
