import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wood_vip/model/rentmodel.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class PurchaselistProvider extends ChangeNotifier {
  RentModel rentModel = RentModel();
  bool loading = false;

  Future<void> getUserRentVideoList() async {
    debugPrint("getUserRentVideoList userID :==> ${Constant.userID}");
    loading = true;
    rentModel = await ApiService().userRentVideoList();
    debugPrint("user_rent_video_list status :==> ${rentModel.status}");
    debugPrint("user_rent_video_list message :==> ${rentModel.message}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    rentModel = RentModel();
  }
}
