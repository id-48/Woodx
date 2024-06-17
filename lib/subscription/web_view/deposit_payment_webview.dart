import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wood_vip/subscription/web_view/webview_widget.dart';
import 'package:wood_vip/utils/color.dart';

class CustomWebViewScreen extends StatefulWidget {
  const CustomWebViewScreen({Key? key, required this.redirectUrl}) : super(key: key);
  final String redirectUrl;

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  @override
  void initState() {
    super.initState();
    permissionServices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MyWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
    // return Container();
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      onPressed: () async {
        Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.cancel,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }
}
