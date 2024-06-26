import 'package:flutter/material.dart';
import 'package:wood_vip/model/profilemodel.dart';
import 'package:wood_vip/model/successmodel.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  SuccessModel successNameModel = SuccessModel();
  SuccessModel uploadImgModel = SuccessModel();

  bool loading = false;

  Future<void> getProfile() async {
    debugPrint("getProfile userID :==> ${Constant.userID}");

    loading = true;
    profileModel = await ApiService().profile();
    debugPrint("get_profile status :==> ${profileModel.status}");
    debugPrint("get_profile message :==> ${profileModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getUpdateProfile(name) async {
    debugPrint("getUpdateProfile userID :==> ${Constant.userID}");
    debugPrint("getUpdateProfile name :==> $name");

    loading = true;
    successNameModel = await ApiService().updateProfile(name);
    debugPrint("update_profile status :==> ${successNameModel.status}");
    debugPrint("update_profile message :==> ${successNameModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getImageUpload(profileImg) async {
    debugPrint("getImageUpload userID :==> ${Constant.userID}");
    debugPrint("getImageUpload profileImg :==> ${profileImg.toString()}");
    loading = true;
    uploadImgModel = await ApiService().imageUpload(profileImg);
    debugPrint("image_upload status :==> ${uploadImgModel.status}");
    debugPrint("image_upload message :==> ${uploadImgModel.message}");
    loading = false;
    notifyListeners();
  }
}
