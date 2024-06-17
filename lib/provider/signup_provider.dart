import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/bottombar.dart';
import '../utils/sharedpre.dart';
import '../utils/utils.dart';

class SignUpProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLogin = false;
  SharedPre sharedPref = SharedPre();
  bool isLoader = false;

  onSignInWithEmailPassword({required BuildContext context}) async {
    isLoader = true;
    notifyListeners();
    if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
      try {
        String emailAddress = emailController.text.trim();
        String password = passwordController.text.trim();
        print("Email :${emailAddress}");
        print('Password : ${password}');
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
        if (credential.user != null) {
          isLoader = false;
          notifyListeners();
          print('emailAddress :::${emailAddress}');
          await sharedPref.save('useremail', emailAddress);
          isLogin = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Bottombar()),
            (Route<dynamic> route) => false,
          );
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          print('SignIn successfully');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Utils.showSnackbar(context, "fail", "No user found for that email.", false);

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Utils.showSnackbar(context, "fail", "${e.message}", false);

          print('Wrong password provided for that user.');
        }
        isLoader = false;
        notifyListeners();
      }
    } else {
      isLoader = false;
      notifyListeners();
      Utils.showSnackbar(context, "fail", "Please enter email/password.", false);
    }

    notifyListeners();
  }

  loginWithEmailPass(BuildContext context) async {
    if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
      try {
        isLoader = true;
        notifyListeners();
        String emailAddress = emailController.text.trim();
        String password = passwordController.text.trim();
        print("Email :${emailAddress}");
        print('Password : ${password}');
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        if (credential.user != null) {
          isLoader = false;
          notifyListeners();
          print('emailAddress33333 :::$emailAddress');

          await sharedPref.save('useremail', emailAddress);
          onChangeWithLogin(true);
          print('Login successfully');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Utils.showSnackbar(context, "fail", "${e.message}", false);

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Utils.showSnackbar(context, "fail", "The account already exists for that email.", false);

          print('The account already exists for that email.');
        }
        isLoader = false;
        notifyListeners();
      }
    } else {
      isLoader = false;
      notifyListeners();
      Utils.showSnackbar(context, "fail", "Please enter email/password.", false);
    }
    notifyListeners();
  }

  onChangeWithLogin(bool login) {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isLogin = login;
    notifyListeners();
  }
}
