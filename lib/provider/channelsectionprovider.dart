import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wood_vip/model/channelsectionmodel.dart';
import 'package:wood_vip/webservice/apiservices.dart';

class ChannelSectionProvider extends ChangeNotifier {
  ChannelSectionModel channelSectionModel = ChannelSectionModel();

  bool loading = false;
  int? cBannerIndex = 0;

  Future<void> getChannelSection() async {
    loading = true;
    channelSectionModel = await ApiService().channelSectionList();
    debugPrint("getChannelSection status :==> ${channelSectionModel.status}");
    debugPrint("getChannelSection message :==> ${channelSectionModel.message}");
    loading = false;
    notifyListeners();
  }

  channelNotifyProvider() {
    notifyListeners();
  }

  setCurrentBanner(index) {
    cBannerIndex = index;
    notifyListeners();
  }

  updatePrimiumPurchase() {
    if (channelSectionModel.result != null) {
      for (var i = 0; i < (channelSectionModel.liveUrl?.length ?? 0); i++) {
        channelSectionModel.liveUrl?[i].isBuy = 1;
      }
    }
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    channelSectionModel = ChannelSectionModel();
  }
}
