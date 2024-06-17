import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wood_vip/model/couponmodel.dart';
import 'package:wood_vip/model/paymentoptionmodel.dart';
import 'package:wood_vip/model/paytmmodel.dart';
import 'package:wood_vip/model/successmodel.dart';
import 'package:wood_vip/utils/constant.dart';
import 'package:wood_vip/webservice/apiservices.dart';

import '../subscription/web_view/deposit_payment_webview.dart';
import '../utils/sharedpre.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentOptionModel paymentOptionModel = PaymentOptionModel();
  PayTmModel payTmModel = PayTmModel();
  SuccessModel successModel = SuccessModel();
  CouponModel couponModel = CouponModel();

  bool loading = false, payLoading = false, couponLoading = false;
  String? currentPayment = "", finalAmount = "";
  SharedPre pref = SharedPre();
  String amount = "";
  String userId = "";
  String packageId = "";

  Future<void> getPaymentOption() async {
    loading = true;
    paymentOptionModel = await ApiService().getPaymentOption();
    debugPrint("getPaymentOption status :==> ${paymentOptionModel.status}");
    debugPrint("getPaymentOption message :==> ${paymentOptionModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> applyPackageCouponCode(couponCode, packageId) async {
    debugPrint("applyPackageCouponCode couponCode :==> $couponCode");
    debugPrint("applyPackageCouponCode packageId :==> $packageId");
    couponLoading = true;
    couponModel = await ApiService().applyPackageCoupon(couponCode, packageId);
    debugPrint("applyPackageCouponCode status :==> ${couponModel.status}");
    debugPrint("applyPackageCouponCode message :==> ${couponModel.message}");
    couponLoading = false;
    notifyListeners();
  }

  Future<void> applyRentCouponCode(couponCode, videoId, typeId, videoType, price) async {
    debugPrint("applyRentCouponCode couponCode :==> $couponCode");
    debugPrint("applyRentCouponCode videoId :==> $videoId");
    debugPrint("applyRentCouponCode typeId :==> $typeId");
    debugPrint("applyRentCouponCode videoType :==> $videoType");
    debugPrint("applyRentCouponCode price :==> $price");
    couponLoading = true;
    couponModel = await ApiService().applyRentCoupon(couponCode, videoId, typeId, videoType, price);
    debugPrint("applyRentCouponCode status :==> ${couponModel.status}");
    debugPrint("applyRentCouponCode message :==> ${couponModel.message}");
    couponLoading = false;
    notifyListeners();
  }

  setFinalAmount(String? amount) {
    finalAmount = amount;
    debugPrint("setFinalAmount finalAmount :==> $finalAmount");
    notifyListeners();
  }

  Future<void> getPaytmToken(
      merchantID, orderId, custmoreID, channelID, txnAmount, website, callbackURL, industryTypeID) async {
    debugPrint("getPaytmToken merchantID :=======> $merchantID");
    debugPrint("getPaytmToken orderId :==========> $orderId");
    debugPrint("getPaytmToken custmoreID :=======> $custmoreID");
    debugPrint("getPaytmToken channelID :========> $channelID");
    debugPrint("getPaytmToken txnAmount :========> $txnAmount");
    debugPrint("getPaytmToken website :==========> $merchantID");
    debugPrint("getPaytmToken callbackURL :======> $merchantID");
    debugPrint("getPaytmToken industryTypeID :===> $industryTypeID");
    loading = true;
    payTmModel = await ApiService()
        .getPaytmToken(merchantID, orderId, custmoreID, channelID, txnAmount, website, callbackURL, industryTypeID);
    debugPrint("getPaytmToken status :===> ${payTmModel.status}");
    debugPrint("getPaytmToken message :==> ${payTmModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> addTransaction(packageId, description, amount, paymentId, currencyCode, couponCode) async {
    debugPrint("addTransaction userID :==> ${Constant.userID}");
    debugPrint("addTransaction packageId :==> $packageId");
    debugPrint("addTransaction couponCode :==> $couponCode");
    payLoading = true;
    successModel =
        await ApiService().addTransaction(packageId, description, amount, paymentId, currencyCode, couponCode);
    debugPrint("addTransaction status :==> ${successModel.status}");
    debugPrint("addTransaction message :==> ${successModel.message}");
    payLoading = false;
    notifyListeners();
  }

  Future<void> addRentTransaction(videoId, amount, typeId, videoType, couponCode) async {
    debugPrint("addRentTransaction userID :==> ${Constant.userID}");
    debugPrint("addRentTransaction videoId :==> $videoId");
    debugPrint("addRentTransaction couponCode :==> $couponCode");
    payLoading = true;
    successModel = await ApiService().addRentTransaction(videoId, amount, typeId, videoType, couponCode);
    debugPrint("addRentTransaction status :==> ${successModel.status}");
    debugPrint("addRentTransaction message :==> ${successModel.message}");
    payLoading = false;
    notifyListeners();
  }

  setCurrentPayment(String? payment) {
    currentPayment = payment;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    currentPayment = "";
    finalAmount = "";
    paymentOptionModel = PaymentOptionModel();
    successModel = SuccessModel();
  }

  onPhonePaySelect({required BuildContext context}) async {
    amount = await pref.read("amount");
    userId = await pref.read("userId");
    packageId = await pref.read("packageId");
    print('Amount :: $amount\n User Id :: $userId\n Package Id :${packageId}');
    notifyListeners();
    if (amount.isNotEmpty && userId.isNotEmpty && packageId.isNotEmpty) {
      var resBuyPlan = await ApiService().phonePayApiCall(userId: userId, amount: "${amount}00", packageId: packageId);
      await pref.remove("amount");
      await pref.remove("userId");
      await pref.remove("packageId");
      if (resBuyPlan.data != null) {
        if (resBuyPlan.data.paymentId != null) {
          if (resBuyPlan.data.paymentId.isNotEmpty) {
            await pref.save("prePlanPaymentId", resBuyPlan.data.paymentId);
          }
        }

        if (resBuyPlan.data.url.isNotEmpty) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CustomWebViewScreen(redirectUrl: resBuyPlan.data.url)));
        }
      }
    }
  }
}
