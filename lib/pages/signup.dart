import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wood_vip/utils/color.dart';
import 'package:wood_vip/widget/mytext.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  'Let’s\nLogin with Email',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 33),
                ),
              ),
              /* Enter Email */
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 0.7,
                  ),
                  color: edtBG,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: emailController,
                  style: const TextStyle(fontSize: 16, color: white),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: GoogleFonts.montserrat(
                      color: otherColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Enter your email",
                  ),
                ),
              ),
              const SizedBox(height: 25),

              /* Enter Password */
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 0.7,
                  ),
                  color: edtBG,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: passwordController,
                  style: const TextStyle(fontSize: 16, color: white),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: GoogleFonts.montserrat(
                      color: otherColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Enter your password",
                  ),
                ),
              ),
              const SizedBox(height: 25),

              /* Enter Confirm Password */
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 0.7,
                  ),
                  color: edtBG,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: confirmPasswordController,
                  style: const TextStyle(fontSize: 16, color: white),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: GoogleFonts.montserrat(
                      color: otherColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Enter your confirm password",
                  ),
                ),
              ),
              const SizedBox(height: 50),

              /* Login Button */
              InkWell(
                onTap: () {
                  // debugPrint("Click mobileNumber ==> $mobileNumber");
                  // if (numberController.text.toString().isEmpty) {
                  //   Utils.showSnackbar(
                  //       context, "info", "login_with_mobile_note", true);
                  // } else {
                  //   log("mobileNumber ==> $mobileNumber");
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => OTPVerify(mobileNumber ?? ""),
                  //     ),
                  //   );
                  // }
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primaryLight,
                        primaryDark,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    color: white,
                    text: "signup",
                    multilanguage: true,
                    fontsizeNormal: 17,
                    fontsizeWeb: 19,
                    fontweight: FontWeight.w700,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
