import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wood_vip/model/subscriptionmodel.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionModel subscriptionModel = SubscriptionModel();

  bool loading = false;

  Future<void> getPackages() async {
    debugPrint("getPackages userID :==> ${Constant.userID}");
    loading = true;
    subscriptionModel = await ApiService().subscriptionPackage();
    debugPrint("get_package status :==> ${subscriptionModel.status}");
    debugPrint("get_package message :==> ${subscriptionModel.message}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearSubscriptionProvider ================>");
    subscriptionModel = SubscriptionModel();
  }
}
