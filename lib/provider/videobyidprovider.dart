import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wood_vip/model/videobyidmodel.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class VideoByIDProvider extends ChangeNotifier {
  VideoByIdModel videoByIdModel = VideoByIdModel();

  bool loading = false;

  Future<void> getVideoByCategory(categoryID, typeId) async {
    debugPrint("getVideoByCategory userID :======> ${Constant.userID}");
    debugPrint("getVideoByCategory categoryID :==> $categoryID");
    debugPrint("getVideoByCategory typeId :======> $typeId");
    loading = true;
    videoByIdModel = await ApiService().videoByCategory(categoryID, typeId);
    debugPrint("video_by_category status :==> ${videoByIdModel.status}");
    debugPrint("video_by_category message :==> ${videoByIdModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getVideoByLanguage(languageID, typeId) async {
    debugPrint("getVideoByLanguage userID :======> ${Constant.userID}");
    debugPrint("getVideoByLanguage languageID :==> $languageID");
    debugPrint("getVideoByLanguage typeId :======> $typeId");
    loading = true;
    videoByIdModel = await ApiService().videoByLanguage(languageID, typeId);
    debugPrint("video_by_language status :==> ${videoByIdModel.status}");
    debugPrint("video_by_language message :==> ${videoByIdModel.message}");
    loading = false;
    notifyListeners();
  }

  clearVideoByIDProvider() {
    log("<================ clearVideoByIDProvider ================>");
    videoByIdModel = VideoByIdModel();
  }
}
