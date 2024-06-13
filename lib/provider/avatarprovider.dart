import 'package:flutter/material.dart';
import 'package:wood_vip/model/avatarmodel.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class AvatarProvider extends ChangeNotifier {
  AvatarModel avatarModel = AvatarModel();

  bool loading = false;

  Future<void> getAvatar() async {
    loading = true;
    avatarModel = await ApiService().getAvatar();
    debugPrint("getAvatar status :==> ${avatarModel.status}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    avatarModel = AvatarModel();
  }
}
