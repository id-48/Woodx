import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wood_vip/utils/color.dart';
import 'package:wood_vip/widget/mytext.dart';

import '../provider/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpProvider signUpProvider;

  @override
  void initState() {
    signUpProvider = Provider.of<SignUpProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<SignUpProvider>(builder: (context, signUpProvider, child) {
            return Form(
              key: signUpProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      'Let’s\nLogin with Email',
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 33),
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
                      controller: signUpProvider.emailController,
                      style: const TextStyle(fontSize: 16, color: white),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      textAlignVertical: TextAlignVertical.center,
                      controller: signUpProvider.passwordController,
                      style: const TextStyle(fontSize: 16, color: white),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  signUpProvider.isLogin
                      ? SizedBox()
                      :
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
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Enter Password';
                              } else if (signUpProvider.passwordController.text !=
                                  signUpProvider.confirmPasswordController.text) {
                                return "Confirm password is not same as password!";
                              }
                              return null;
                            },
                            textAlignVertical: TextAlignVertical.center,
                            controller: signUpProvider.confirmPasswordController,
                            style: const TextStyle(fontSize: 16, color: white),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  signUpProvider.isLoader
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            if (signUpProvider.formKey.currentState!.validate()) {
                              if (!signUpProvider.isLogin) {
                                await signUpProvider.loginWithEmailPass(context);
                              } else {
                                await signUpProvider.onSignInWithEmailPassword(context: context);
                              }
                            }

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
                              text: signUpProvider.isLogin ? "login" : "signup",
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
                  signUpProvider.isLogin
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              color: white,
                              text: "donthaveaccount",
                              multilanguage: true,
                              fontsizeNormal: 12,
                              fontsizeWeb: 19,
                              fontweight: FontWeight.w500,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                signUpProvider.onChangeWithLogin(false);
                              },
                              child: MyText(
                                color: primaryColor,
                                text: "signupnow",
                                multilanguage: true,
                                fontsizeNormal: 12,
                                fontsizeWeb: 19,
                                fontweight: FontWeight.w500,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              color: white,
                              text: "alreadyhaveacoount",
                              multilanguage: true,
                              fontsizeNormal: 12,
                              fontsizeWeb: 19,
                              fontweight: FontWeight.w500,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                signUpProvider.onChangeWithLogin(true);
                              },
                              child: MyText(
                                color: primaryColor,
                                text: "login",
                                multilanguage: true,
                                fontsizeNormal: 12,
                                fontsizeWeb: 19,
                                fontweight: FontWeight.w500,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
