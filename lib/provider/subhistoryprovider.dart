import 'package:flutter/material.dart';
import 'package:wood_vip/model/historymodel.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class SubHistoryProvider extends ChangeNotifier {
  HistoryModel historyModel = HistoryModel();

  bool loading = false;

  Future<void> getSubscriptionList() async {
    loading = true;
    historyModel = await ApiService().subscriptionList();
    debugPrint("subscription_list status :==> ${historyModel.status}");
    debugPrint("subscription_list message :==> ${historyModel.message}");
    loading = false;
    notifyListeners();
  }

  clearProvider() {
    debugPrint("============ clearSearchProvider ============");
    historyModel = HistoryModel();
  }
}
