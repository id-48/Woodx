import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wood_vip/pages/bottombar.dart';
import 'package:wood_vip/pages/intro.dart';
import 'package:wood_vip/provider/homeprovider.dart';
import 'package:wood_vip/tvpages/tvhome.dart';
import 'package:wood_vip/utils/color.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/utils/sharedpre.dart';
import 'package:wood_vip/widget/myimage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? seen;
  SharedPre sharedPre = SharedPre();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (!mounted) return;
      isFirstCheck();
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: appBgColor,
        child: MyImage(
          imagePath: (kIsWeb || Constant.isTV) ? "appicon.png" : "splash.png",
          fit: (kIsWeb || Constant.isTV) ? BoxFit.contain : BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> isFirstCheck() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.setLoading(true);

    seen = await sharedPre.read('seen') ?? "0";
    Constant.userID = await sharedPre.read('userid');
    log('seen ==> $seen');
    log('Constant userID ==> ${Constant.userID}');
    if (!mounted) return;

    if (kIsWeb || Constant.isTV) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const TVHome(pageName: "");
          },
        ),
      );
    } else {
      if (seen == "1") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Bottombar();
            },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Intro();
            },
          ),
        );
      }
    }
  }
}
