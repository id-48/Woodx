import 'package:flutter/material.dart';
import 'package:wood_vip/model/castdetailmodel.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class CastDetailsProvider extends ChangeNotifier {
  CastDetailModel castDetailModel = CastDetailModel();

  bool loading = false;

  Future<void> getCastDetails(castID) async {
    loading = true;
    castDetailModel = await ApiService().getCastDetails(castID);
    debugPrint("getCastDetails status :==> ${castDetailModel.status}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    castDetailModel = CastDetailModel();
  }
}
